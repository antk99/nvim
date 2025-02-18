local neovim_logo = {
  [[                                                                       ]],
  [[                                                                     ]],
  [[       ████ ██████           █████      ██                     ]],
  [[      ███████████             █████                             ]],
  [[      █████████ ███████████████████ ███   ███████████   ]],
  [[     █████████  ███    █████████████ █████ ██████████████   ]],
  [[    █████████ ██████████ █████████ █████ █████ ████ █████   ]],
  [[  ███████████ ███    ███ █████████ █████ █████ ████ █████  ]],
  [[ ██████  █████████████████████ ████ █████ █████ ████ ██████ ]],
  [[                                                                       ]],
}

return {
  "goolord/alpha-nvim",
  event = "VimEnter",
  config = function()
    local alpha = require("alpha")
    local dashboard = require("alpha.themes.dashboard")

    -- Set header
    dashboard.section.header.val = neovim_logo

    -- Set menu
    dashboard.section.buttons.val = {
      dashboard.button("n", "📃 > New File", "<cmd>ene<CR>"),
      dashboard.button("r", "📂 > Open Recent File", "<cmd>Telescope oldfiles<CR>"),
      dashboard.button("f", "🔎 > Find File", "<cmd>Telescope find_files<CR>"),
      dashboard.button("s", "⏮️  > Restore Session For Current Directory", "<cmd>SessionRestore<CR>"),
      dashboard.button("e", "🛠 > Edit Neovim Config", "<cmd>lua OpenNvimConfig()<CR>"),
      dashboard.button("q", "❌ > Quit NVIM", "<cmd>qa<CR>"),
    }

    function OpenNvimConfig()
      local cmd
      if vim.fn.has("mac") == 1 then
        cmd = "open -a Terminal ~/.config/nvim; exit"
      elseif vim.fn.has("unix") == 1 then
        -- cmd = "alacritty -e bash -c 'cd ~/.config/nvim && nvim' & disown"
        -- Alternative for other terminals:
        -- cmd = "kitty sh -c 'cd ~/.config/nvim && nvim'"
        -- cmd = "xfce4-terminal -e 'sh -c \"cd ~/.config/nvim && nvim\"'"
        cmd = "gnome-terminal -- bash -c 'cd ~/.config/nvim && nvim'"
      elseif vim.fn.has("win32") == 1 then
        cmd = "start cmd /k cd %USERPROFILE%\\.config\\nvim && nvim"
      else
        print("Unsupported OS")
        return
      end

      os.execute(cmd)
    end

    -- Send config to alpha
    alpha.setup(dashboard.opts)

    -- Disable folding on alpha buffer
    vim.cmd([[autocmd FileType alpha setlocal nofoldenable]])
  end,
}
