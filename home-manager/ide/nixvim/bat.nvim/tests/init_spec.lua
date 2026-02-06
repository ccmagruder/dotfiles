-- Setup paths before requiring bat
local bat_path = vim.env.BAT_PATH
if bat_path then
  package.path = string.format("%s/lua/?.lua;%s/lua/?/init.lua;%s", bat_path, bat_path, package.path)
end

local bat = require("bat")

describe("bat.init", function()
  describe("_find_bat_window", function()
    it("should return nil when no bat window exists", function()
      local result = bat._find_bat_window()
      assert.is_nil(result)
    end)

    it("should return window id when bat window exists", function()
      -- Create a bat window manually
      vim.cmd("rightbelow vsplit")
      local win = vim.api.nvim_get_current_win()
      vim.api.nvim_win_set_var(win, "is_bat_window", true)

      local result = bat._find_bat_window()
      assert.are.equal(win, result)

      -- Cleanup
      vim.api.nvim_win_close(win, false)
    end)
  end)

  describe("_create_bat_window", function()
    it("should create window on the right", function()
      local initial_window = vim.api.nvim_get_current_win()
      local bat_window = bat._create_bat_window()

      local initial_col = vim.api.nvim_win_get_position(initial_window)[2]
      local bat_col = vim.api.nvim_win_get_position(bat_window)[2]
      assert.is_true(bat_col > initial_col)

      -- Cleanup
      vim.api.nvim_win_close(bat_window, false)
    end)

    it("should preserve cursor position", function()
      local initial_window = vim.api.nvim_get_current_win()
      bat._create_bat_window()

      assert.are.equal(initial_window, vim.api.nvim_get_current_win())

      -- Cleanup: find and close bat window
      local bat_win = bat._find_bat_window()
      if bat_win then vim.api.nvim_win_close(bat_win, false) end
    end)

    it("should mark window with is_bat_window variable", function()
      local bat_window = bat._create_bat_window()

      local ok, is_bat = pcall(vim.api.nvim_win_get_var, bat_window, "is_bat_window")
      assert.is_true(ok)
      assert.is_true(is_bat)

      -- Cleanup
      vim.api.nvim_win_close(bat_window, false)
    end)
  end)

  describe("_delete_bat_buffers", function()
    it("should delete buffers marked as bat buffers", function()
      -- Create a hidden bat buffer (not displayed in any window)
      local buf = vim.api.nvim_create_buf(true, true)
      vim.api.nvim_buf_set_var(buf, "is_bat_buffer", true)

      assert.is_true(vim.api.nvim_buf_is_valid(buf))

      bat._delete_bat_buffers()

      assert.is_false(vim.api.nvim_buf_is_valid(buf))
    end)

    it("should not delete regular buffers", function()
      -- Create a regular buffer
      vim.cmd("enew")
      local buf = vim.api.nvim_get_current_buf()
      vim.api.nvim_buf_set_lines(buf, 0, -1, false, { "test content" })

      local initial_count = #vim.api.nvim_list_bufs()

      bat._delete_bat_buffers()

      assert.is_true(vim.api.nvim_buf_is_valid(buf))
      assert.are.equal(initial_count, #vim.api.nvim_list_bufs())
    end)
  end)

  describe("_get_channel_info", function()
    it("should return channel info for terminal window", function()
      -- Create a new window with a scratch buffer for terminal
      local buf = vim.api.nvim_create_buf(false, true)
      vim.cmd("rightbelow vsplit")
      local win = vim.api.nvim_get_current_win()
      vim.api.nvim_win_set_buf(win, buf)
      vim.fn.termopen({ "bash", "-c", "echo test" })

      local info = bat._get_channel_info(win)

      assert.are.equal("terminal", info.mode)
      assert.is_table(info.argv)

      -- Cleanup
      vim.api.nvim_win_close(win, true)
    end)
  end)

  describe("_create_bat_buffer", function()
    it("should create a buffer marked as bat buffer", function()
      -- Create in a separate window with empty buffer
      vim.cmd("rightbelow vsplit | enew")
      local win = vim.api.nvim_get_current_win()

      bat._create_bat_buffer("echo test")

      local buf = vim.api.nvim_get_current_buf()
      local ok, is_bat = pcall(vim.api.nvim_buf_get_var, buf, "is_bat_buffer")
      assert.is_true(ok)
      assert.is_true(is_bat)

      -- Cleanup
      vim.api.nvim_win_close(win, true)
    end)

    it("should start a terminal with the command", function()
      vim.cmd("rightbelow vsplit | enew")
      local win = vim.api.nvim_get_current_win()

      bat._create_bat_buffer("echo hello")

      local buf = vim.api.nvim_get_current_buf()
      local chan_id = vim.bo[buf].channel
      local info = vim.api.nvim_get_chan_info(chan_id)

      assert.are.equal("terminal", info.mode)
      assert.match("echo hello", info.argv[3])

      -- Cleanup
      vim.api.nvim_win_close(win, true)
    end)
  end)

  describe("_in_window", function()
    it("should execute function in specified window", function()
      vim.cmd("rightbelow vsplit")
      local other_win = vim.api.nvim_get_current_win()
      vim.cmd("wincmd p")
      local initial_win = vim.api.nvim_get_current_win()

      local executed_in_win = nil
      bat._in_window(other_win, function()
        executed_in_win = vim.api.nvim_get_current_win()
      end)

      assert.are.equal(other_win, executed_in_win)

      -- Cleanup
      vim.api.nvim_win_close(other_win, false)
    end)

    it("should preserve original window focus", function()
      vim.cmd("rightbelow vsplit")
      local other_win = vim.api.nvim_get_current_win()
      vim.cmd("wincmd p")
      local initial_win = vim.api.nvim_get_current_win()

      bat._in_window(other_win, function() end)

      assert.are.equal(initial_win, vim.api.nvim_get_current_win())

      -- Cleanup
      vim.api.nvim_win_close(other_win, false)
    end)
  end)

  describe("parse_json", function()
    it("should parse a json chosen by user settings", function()
      -- Create temp test file
      local test_file = "/tmp/.bat-test.json"
      vim.fn.writefile({ '{"build": "echo \'Hello World\'"}' }, test_file)

      local cmds = bat.parse_json(test_file)
      assert.match("echo 'Hello World'", cmds["build"])

      -- Cleanup
      os.remove(test_file)
    end)

    it("should gracefully error when .bat.json is missing", function()
      -- Generate error message
      local ok, err = pcall(bat.parse_json, "/nonexistent/path/.bat.json")

      -- Assert expected error message is raised
      assert.is_false(ok)
      assert.is_string(err)
      assert.match("Can't open file /nonexistent/path/.bat.json", err)
    end)
  end)

  describe("_open_window", function()
    it("should open on the right side without changing focus", function()
      -- Get initial state
      local initial_window = vim.api.nvim_get_current_win()

      -- Open the bat window
      local bat_window = bat._open_window()

      -- Assert bat window is on the right of the initial window
      local initial_column = vim.api.nvim_win_get_position(initial_window)[2]
      local bat_column = vim.api.nvim_win_get_position(bat_window)[2]
      assert.is_true(bat_column > initial_column)

      -- Close bat window for next test
      vim.api.nvim_win_close(bat_window, false)
    end)

    it("should not create a second bat window", function()
      -- Get initial state
      local initial_window = vim.api.nvim_get_current_win()

      -- First call: open the bat window
      bat._open_window()
      local bat_window = vim.api.nvim_get_current_win()
      local win_count_after_first_open = #vim.api.nvim_list_wins()

      -- Assert window focus remains unchanged
      assert.are.equal(initial_window, vim.api.nvim_get_current_win())

      -- Second call: should not create new window
      bat._open_window()

      -- Assert window focus remains unchanged
      assert.are.equal(initial_window, vim.api.nvim_get_current_win())

      -- Verify no new window was created
      local final_win_count = #vim.api.nvim_list_wins()
      assert.are.equal(win_count_after_first_open, final_win_count)

      -- Close bat window for next test
      vim.api.nvim_win_close(bat_window, false)
    end)
  end)

  describe("run", function()
    it("should run commands within a bat window terminal", function()
      -- Clean up any leftover bat buffers from previous tests
      bat._delete_bat_buffers()

      local cmd = "echo 'Hello World'"
      local info = bat.run(cmd)

      -- Assert terminal is running cmd
      assert.are.equal("terminal", info.mode)
      assert.match("bash", info.argv[1])
      assert.match("-c", info.argv[2])
      assert.match(cmd, info.argv[3])
    end)

    it("should close old bat buffers when rerunning", function()
      -- Run a command
      local cmd = "echo 'Hello World'"

      -- Capture the number of buffers before/after bat.run()
      local initial_bufs = #vim.api.nvim_list_bufs()
      local info = bat.run(cmd)
      local after_open_window_bufs = #vim.api.nvim_list_bufs()

      -- Assert the number of buffers is not incremented
      assert.are.equal(initial_bufs, after_open_window_bufs)
    end)
  end)
end)
