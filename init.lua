-- Remapper <leader>
vim.g.mapleader = " "
vim.g.maplocalleader = " "

-- Remapper le raccourci pour quitter le terminal mode
vim.keymap.set('t', '<Esc>', [[<C-\><C-n>]], { noremap = true })


-- Lazy.nvim
-- Installer si pas déjà fait
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git", "clone", "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git", "--branch=stable", lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

-- Installer le LSP
require("lazy").setup({
  {
    "neovim/nvim-lspconfig",
    config = function()
    local capabilities = require("cmp_nvim_lsp").default_capabilities()

    -- C/C++
    vim.lsp.config("clangd", {
      capabilities = capabilities,
    })
    vim.lsp.enable("clangd")

    -- PHP
    vim.lsp.config("intelephense", {
      capabilities = capabilities,
    })
    vim.lsp.enable("intelephense")

    -- HTML
    vim.lsp.config("html", {
      capabilities = capabilities,
    })
    vim.lsp.enable("html")

    -- CSS
    vim.lsp.config("cssls", {
      capabilities = capabilities,
    })
    vim.lsp.enable("cssls")

    -- Python 
    vim.lsp.config("pyright", {
      capabilities = capabilities,
    })
    vim.lsp.enable("pyright")

    -- Pour linting/format Python 
    vim.lsp.config("ruff", {
      capabilities = capabilities  
    })
    vim.lsp.enable("ruff")

    -- Golang
    vim.lsp.config("gopls", {
      capabilities = capabilities
    })
    vim.lsp.enable("gopls")

    -- Raccourcis utiles LSP
    local opts = { noremap=true, silent=true }
    vim.keymap.set('n', 'gd', vim.lsp.buf.definition, opts)
    vim.keymap.set('n', 'K', vim.lsp.buf.hover, opts)
    vim.keymap.set('n', 'gr', vim.lsp.buf.references, opts)
    vim.keymap.set('n', '<leader>rn', vim.lsp.buf.rename, opts)
  end

  },
  -- Syntax highlighting amélioré
  {
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",
    config = function(_, opts)
      require("nvim-treesitter.configs").setup {
        ensure_installed = { "c", "cpp", "c_sharp", "php", "html", "css", "javascript", "python", "go" },
        highlight = { enable = true },
        indent = { enable = true },
      }
    end
  },
  -- Autocompletion
  {
    "hrsh7th/nvim-cmp",
    dependencies = {
      "hrsh7th/cmp-nvim-lsp",
      "hrsh7th/cmp-buffer",
      "hrsh7th/cmp-path",
      "hrsh7th/cmp-cmdline",
      "L3MON4D3/LuaSnip",
      "saadparwaiz1/cmp_luasnip",
    },
    config = function()
      local cmp = require("cmp")
      local luasnip = require("luasnip")

      cmp.setup({
        snippet = {
          expand = function(args)
            luasnip.lsp_expand(args.body)
          end,
        },
        mapping = {
          ["<Tab>"] = cmp.mapping(function(fallback)
            if cmp.visible() then
              cmp.select_next_item({ behavior = cmp.SelectBehavior.Select })
            else
              fallback()
            end
          end, { "i", "s" }),

          ["<S-Tab>"] = cmp.mapping(function(fallback)
            if cmp.visible() then
              cmp.select_prev_item({ behavior = cmp.SelectBehavior.Select })
            else
              fallback()
            end
          end, { "i", "s" }),

          ["<CR>"] = cmp.mapping.confirm({ select = true }),
        },
        sources = cmp.config.sources({
          { name = "nvim_lsp" },
          { name = "luasnip" },
        }, {
          { name = "buffer" },
          { name = "path" },
        })
      })
    end
  },
  -- highlighting pour les commentaires TODO, FIX, HACK, NOTE, PERF et WARNING
  -- PERF : algorithme de ZINZIN il est super performant !
  -- TODO : à faire
  -- FIX : à corriger
  -- HACK : chelou mais ça fonctionne
  -- NOTE : l'algorithme existe dans la STL
  -- WARNING : attention, algorithme gourmand en mémoire
  {
    "folke/todo-comments.nvim",
    dependencies = { "nvim-lua/plenary.nvim" },
    opts = {
      -- à consulter sur le github du plugin
    }
  },
  -- Package manager pour installer des LSP, DAP, linters et formatters
  {
    "mason-org/mason.nvim",
    opts = {}
  },
  -- Arborescence de fichiers
  {
    "nvim-tree/nvim-tree.lua",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    config = function()
      require("nvim-tree").setup()

      -- Raccourci pour ouvrir/fermer l'arborescence
      vim.keymap.set("n", "<leader>e", ":NvimTreeToggle<CR>", { noremap = true, silent = true })
    end
  },
  -- Liste de raccourcis + descriptions de ces derniers   
  {
    "folke/which-key.nvim",
    event = "VeryLazy",
    config = function()
      local wk = require("which-key")
      wk.setup({
        win = { border = "rounded" },
        layout = { align = "center" },
      })

      -- Liste des raccourcis personnalisés
      wk.add({
        ["<leader>"] = {
          b = {
            name = "Buffer",
            n = { "<cmd>bnext<cr>", "Prochain buffer (vers la droite)" },
            v = { "<cmd>bnext<cr>", "Prochain buffer (vers la gauche)" },
          },
          r = { name = "Renommer",
            n = { "<cmd>rn<cr>", "Renommer la variable/fonction sous le curseur dans tout le fichier" }
          },
        },
      })
      end
  },
  -- Barre d'état plus belle que celle par défaut + icônes sur cette dernière 
  {
    "nvim-lualine/lualine.nvim",
    dependencies = { "nvim-tree/nvim-web-devicons", opt = true },
    config = function()
      require("lualine").setup{
        options = {
        theme = "codedark",       -- peux changer par 'gruvbox', 'onedark', etc
        icons_enabled = true,
        component_separators = { left = "", right = "" },
        section_separators = { left = "", right = "" },
        disabled_filetypes = {},
      },
      sections = {
        lualine_a = {"mode"},
        lualine_b = {"branch", "diff", "diagnostics"},
        lualine_c = {"filename"},
        lualine_x = {"encoding", "fileformat", "filetype"},
        lualine_y = {"progress"},
        lualine_z = {"location"}
      },
      inactive_sections = {
        lualine_a = {},
        lualine_b = {},
        lualine_c = {"filename"},
        lualine_x = {"location"},
        lualine_y = {},
        lualine_z = {}
      },
      tabline = {},
      extensions = {}
      }
      end
  },
  -- Pour afficher les buffers ouverts comme des onglets en haut de la fenêtre 
  {
    "akinsho/bufferline.nvim",
    version = "*",
    dependencies = "nvim-tree/nvim-web-devicons",
    config = function()
    	vim.opt.termguicolors = true,
      -- Nouveau buffer
      vim.keymap.set("n", "<leader>be", ":enew<CR>", { noremap = true, silent = true })

      -- Naviguer entre buffers
      vim.keymap.set("n", "<leader>bv", ":BufferLineCyclePrev<CR>", { noremap = true, silent = true })
      vim.keymap.set("n", "<leader>bn", ":BufferLineCycleNext<CR>", { noremap = true, silent = true })

      -- Fermer buffer courant
      vim.keymap.set("n", "<leader>bd", ":bdelete<CR>", { noremap = true, silent = true })
    	require("bufferline").setup{
      	options = {
          numbers = "ordinal",
          diagnostics = "nvim_lsp",
          separator_style = "slant",
          always_show_bufferline = true,
        }
    }
    end
  },
  -- Discord Rich Presence
  {
    "vyfor/cord.nvim",
    build = ":Cord update",
    -- opts = {}
  },
  -- Rendu de fichiers Markdown
  {
    'MeanderingProgrammer/render-markdown.nvim',
    dependencies = { 'nvim-treesitter/nvim-treesitter', 'echasnovski/mini.nvim' }, -- if you use the mini.nvim suite
    -- dependencies = { 'nvim-treesitter/nvim-treesitter', 'echasnovski/mini.icons' }, -- if you use standalone mini plugins
    -- dependencies = { 'nvim-treesitter/nvim-treesitter', 'nvim-tree/nvim-web-devicons' }, -- if you prefer nvim-web-devicons
    ---@module 'render-markdown'
    ---@type render.md.UserConfig
    opts = {
      completions = { lsp = { enabled = true } },
    },    
  },
})

-- Thème 
vim.cmd("colorscheme industry")

-- Numérotation des lignes
vim.opt.number = true
vim.opt.relativenumber = true

-- Indentation et tabulation
vim.opt.tabstop = 2 
vim.opt.shiftwidth = 2 
vim.opt.expandtab = true  
vim.opt.smartindent = true 

-- Recherche
vim.opt.ignorecase = true 
vim.opt.smartcase = true 
vim.opt.hlsearch = true 
vim.opt.incsearch = true 

-- Interface
vim.opt.cursorline = true 
vim.opt.wrap = false 
vim.opt.scrolloff = 8 
vim.opt.signcolumn = "yes" 
vim.opt.updatetime = 200 -- en millisecondes

-- Afficher automatiquement le diagnostic sous forme de popup quand le curseur est sur la ligne
vim.api.nvim_create_autocmd("CursorHold", {
  callback = function()
    vim.diagnostic.open_float(nil, { focus = false })
  end
})

-- Folding basé sur Treesitter
vim.o.foldmethod = "expr"
vim.o.foldexpr = "nvim_treesitter#foldexpr()"
vim.o.foldlevel = 99  -- Plie tout mais reste ouvert à ce niveau
vim.o.foldenable = true
vim.opt.foldmethod = "marker"
vim.opt.foldmarker = "{{{,}}}"

-- Système
vim.opt.clipboard = "unnamedplus" 
