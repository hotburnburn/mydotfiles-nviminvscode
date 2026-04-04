return {
  {
    'folke/flash.nvim',
    event = 'VeryLazy',
    opts = {
      modes = {
        char = {
          enabled = true, -- 必须开启 char 模式才能接管按键
          keys = { 't', 'T' }, -- 核心逻辑：覆盖默认的 {"f", "F", "t", "T", ";", ","}，只让 flash 接管 't'
        },
        treesitter = {
          enabled = false,
        },
      },
    },
    keys = {
      {
        'f',
        mode = { 'n', 'x', 'o' },
        function()
          require('flash').jump()
        end,
        desc = 'Flash',
      },
    },
  },
}
