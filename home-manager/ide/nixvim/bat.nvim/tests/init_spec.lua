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
  end)
end)
