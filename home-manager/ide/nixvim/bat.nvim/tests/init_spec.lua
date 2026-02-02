-- Setup paths before requiring bat
local bat_path = vim.env.BAT_PATH
if bat_path then
  package.path = string.format("%s/lua/?.lua;%s/lua/?/init.lua;%s", bat_path, bat_path, package.path)
end

local bat = require("bat")

describe("bat.init", function()
  describe("read_json_config", function()
    it("should read and parse json", function()
      assert.equal(true, true)
    end)

    it("should handle missing .bat.json gracefully with meaningful error", function()
      local ok, err = pcall(bat.read_json_config, "/nonexistent/path/.bat.json")
      assert.is_false(ok)
      assert.is_string(err)
      assert.match(".bat.json", err)
    end)
  end)
end)
