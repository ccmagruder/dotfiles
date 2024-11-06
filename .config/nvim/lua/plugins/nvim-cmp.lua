return {
  {
    'hrsh7th/nvim-cmp',

    dependencies = {
      'hrsh7th/cmp-buffer',
      'hrsh7th/cmp-nvim-lsp',
      'hrsh7th/cmp-cmdline',
      'hrsh7th/cmp-path',
      'hrsh7th/cmp-nvim-lua',
      'hrsh7th/cmp-nvim-lsp-signature-help',
      'onsails/lspkind.nvim',
    },

    opts = function(_, opts)
      opts.sources = opts.sources or {}
      table.insert(opts.sources, {
        name = "lazydev",
        group_index = 0, -- set group index to 0 to skip loading LuaLS completions
      })
    end,

    config = function()
      local cmp = require('cmp')

      cmp.setup({
        snippet = {
          expand = function(args)
            vim.snippet.expand(args.body)
          end,
        },
        window = {
          completion = cmp.config.window.bordered(),
          documentation = cmp.config.window.bordered(),
        },
        mapping = {
          -- ['<Down>'] = {
          --   i = cmp.mapping.select_next_item(
          --     { behavior = cmp.SelectBehavior.Select }
          --   ),
          -- },
          -- ['<Up>'] = {
          --   i = cmp.mapping.select_prev_item(
          --     { behavior = cmp.SelectBehavior.Select }
          --   ),
          -- },
          ['<C-n>'] = {
            i = cmp.mapping.select_next_item(
              { behavior = cmp.SelectBehavior.Insert }
            ),
          },
          ['<C-p>'] = {
            i = cmp.mapping.select_prev_item(
              { behavior = cmp.SelectBehavior.Insert }
            ),
          },
          ['<C-y>'] = {
            -- select = true selects first entry
            i = cmp.mapping.confirm({ select = true }),
          },
          ['<C-e>'] = {
            i = cmp.mapping.abort(),
          },
        },
        sources = cmp.config.sources(
          {
            { name = 'nvim_lsp_signature_help' },
            { name = 'nvim_lua' },
            { name = 'nvim_lsp' },
            { name = 'buffer' },
          }
        ),
        formatting = {
          format = require('lspkind').cmp_format(
            {
              mode = 'symbol_text',
              menu = {
                nvim_lsp_signaure_help = "[sig]",
                nvim_lua = "[api]",
                nvim_lsp = "[lsp]",
                buffer = "[buf]",
                path = "[path]",
                cmdline = "[cmd]",
              },
            }
          ),
        },
      })
      cmp.setup.cmdline({ '/', '?' }, {
        mapping = cmp.mapping.preset.cmdline(),
        sources = {
          { name = 'buffer' }
        },
      })
      cmp.setup.cmdline(':', {
        mapping = cmp.mapping.preset.cmdline(),
        sources = cmp.config.sources(
          {
            { name = 'path' },
          },
          {
            { name = 'cmdline' },
          }
        )
      })
    end,
  },
}

