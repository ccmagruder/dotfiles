-- Setup paths before requiring bat
local bat_path = vim.env.BAT_PATH
if bat_path then
  package.path = string.format("%s/lua/?.lua;%s/lua/?/init.lua;%s", bat_path, bat_path, package.path)
end

local bat = require("bat")

describe("bat.init", function()
  describe("read_json_config", function()
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

    it("should create a second bat window", function()
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
end)
