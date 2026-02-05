-- Setup paths before requiring bat
local bat_path = vim.env.BAT_PATH
if bat_path then
  package.path = string.format("%s/lua/?.lua;%s/lua/?/init.lua;%s", bat_path, bat_path, package.path)
end

local bat = require("bat")

describe("bat.init", function()
  describe("read_json_config", function()
    it("should parse a json chosen by user settings", function()
      -- Create temp test file
      local test_file = "/tmp/.bat-test.json"
      vim.fn.writefile({ '{"build": "echo \'Hello World\'"}' }, test_file)

      local cmds = bat.read_json_config(test_file)
      assert.match("echo 'Hello World'", cmds["build"])

      -- Cleanup
      os.remove(test_file)
    end)

    it("should gracefully error when .bat.json is missing", function()
      -- Generate error message
      local ok, err = pcall(bat.read_json_config, "/nonexistent/path/.bat.json")

      -- Assert expected error message is raised
      assert.is_false(ok)
      assert.is_string(err)
      assert.match("Can't open file /nonexistent/path/.bat.json", err)
    end)
  end)

  describe("open_window", function()
    it("should open on the right side without changing focus", function()
      -- Get initial state
      local initial_window = vim.api.nvim_get_current_win()

      -- Open the bat window
      local bat_window = bat.open_window()

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
      bat.open_window()
      local bat_window = vim.api.nvim_get_current_win()
      local win_count_after_first_open = #vim.api.nvim_list_wins()

      -- Assert window focus remains unchanged
      assert.are.equal(initial_window, vim.api.nvim_get_current_win())

      -- Second call: should not create new window
      bat.open_window()

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
      -- Run a command
      local cmd = "echo 'Hello World'"

      -- Adding to pre-existing buffer to prevent autoremoval when running bat.run()
      vim.api.nvim_buf_set_lines(0, 0, -1, false, { "nonempty buffer" })

      -- Capture the number of buffers before/after bat.run()
      local initial_bufs = #vim.api.nvim_list_bufs()
      local info = bat.run(cmd)
      local after_open_window_bufs = #vim.api.nvim_list_bufs()

      -- Assert the number of buffers is incremented by 1
      assert.are.equal(initial_bufs+1, after_open_window_bufs)

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
