local terminal_cmd = require('nvim-docker.terminal_cmd')

if vim.env["NVIMD_BUILD_CMD"] ~= nil then
  vim.g.nvimd_build_cmd = vim.env["NVIMD_BUILD_CMD"]
else
  vim.g.nvimd_build_cmd = "echo 'Set vim.g.nvim_build_cmd to configure build.'"
end

local function build()
  terminal_cmd(vim.g.nvimd_build_cmd)
end

-- vim.g.nvimd_test_cmd = vim.fn.getcwd() .. '/test.sh'
if vim.env["NVIMD_TEST_CMD"] ~= nil then
  vim.g.nvimd_test_cmd = vim.env["NVIMD_TEST_CMD"]
else
  vim.g.nvimd_test_cmd = "echo 'Set vim.g.nvim_test_cmd to configure test.'"
end

local function test()
  terminal_cmd(vim.g.nvimd_test_cmd)
end

if vim.env["NVIMD_RUN_CMD"] ~= nil then
  vim.g.nvimd_run_cmd = vim.env["NVIMD_RUN_CMD"]
else
  vim.g.nvimd_run_cmd = "echo 'Set vim.g.nvim_run_cmd to configure run.'"
end

local function run()
  terminal_cmd(vim.g.nvimd_run_cmd)
end

local close_buffer = require('nvim-docker.close_buffer')

local function toggle_git_diff()
  local gitsigns = require('gitsigns')
  gitsigns.toggle_linehl()
  gitsigns.toggle_deleted()
end

return {
  build = build,
  test = test,
  run = run,
  close_buffer = close_buffer,
  toggle_git_diff = toggle_git_diff,
}

