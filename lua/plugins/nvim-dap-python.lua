return {
  "mfussenegger/nvim-dap-python",
  pin = true,
  config = function()
    require("dap-python").setup("~/.local/virtualenvs/debugpy/bin/python")
    require("dap-python").test_runner = "pytest"
    require('dap').set_exception_breakpoints({ "raised", "uncaught" })

    require('dap').configurations.python = {
      type = 'python',
      request = 'launch',
      name = 'My custom launch configuration',
      justMyCode = false,
      program = '${file}',
      options = { justMyCode = false }
    }
  end,
}
