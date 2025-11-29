# Neovim Configuration

🇫🇷  
Configuration Neovim personnelle écrite en Lua et basée sur le gestionnaire de plugins lazy.nvim.  
Cette configuration met l’accent sur :  
- le développement (C/C++, Python, Go, PHP, HTML/CSS, JavaScript…)  
- l’autocomplétion, les LSP et le linting  
- l’ergonomie (lualine, bufferline, which-key)  
- la lisibilité (Treesitter, TODO-comments, Markdown rendering)  
- une interface moderne et efficace

🇬🇧  
Personal Neovim configuration written in Lua and using the lazy.nvim plugin manager.  
This setup focuses on:  
- development (C/C++, Python, Go, PHP, HTML/CSS, JavaScript…)  
- autocompletion, LSP support and linting  
- ergonomics (lualine, bufferline, which-key)  
- readability (Treesitter, TODO-comments, Markdown rendering)  
- a modern and efficient UI

## Features / Fonctionnalités

### 🇫🇷 Fonctionnalités principales
- Gestion complète des LSP via nvim-lspconfig  
- Autocomplétion puissante avec nvim-cmp et LuaSnip  
- Arborescence de fichiers via nvim-tree  
- Haute lisibilité du code avec nvim-treesitter  
- Gestion des plugins via lazy.nvim  
- Interface moderne : lualine, bufferline, which-key  
- Support de nombreux langages (C, C++, C#, PHP, HTML, CSS, JS, Python, Go)  
- Thème : industry  
- Confort : diagnostics auto, folding avancé, clipboard système, numérotation relative

### 🇬🇧 Main features
- Full LSP support using nvim-lspconfig  
- Powerful autocompletion with nvim-cmp and LuaSnip  
- File explorer with nvim-tree  
- Enhanced syntax highlighting via nvim-treesitter  
- Plugin management through lazy.nvim  
- Modern UI: lualine, bufferline, which-key  
- Language support (C, C++, C#, PHP, HTML, CSS, JS, Python, Go)  
- Theme: industry  
- QoL improvements: auto diagnostics, advanced folding, system clipboard, relative numbers

## Installation

### 🇫🇷
1. Clonez la configuration :  
git clone https://github.com/ygr671/neovim-configuration ~/.config/nvim

2. Lancez Neovim :  
nvim

3. lazy.nvim installera automatiquement tous les plugins.

### 🇬🇧
1. Clone the configuration:  
git clone https://github.com/ygr671/neovim-configuration ~/.config/nvim

2. Start Neovim:  
nvim

3. lazy.nvim will automatically install all plugins.

## Plugins principaux / Main plugins

### Core
- lazy.nvim  
- nvim-lspconfig  
- mason.nvim  
- nvim-cmp + LuaSnip  
- nvim-treesitter  
- todo-comments.nvim  
- render-markdown.nvim  

### UI / Ergonomie
- nvim-tree  
- lualine.nvim  
- bufferline.nvim  
- which-key.nvim  
- cord.nvim (Discord rich presence)

## Raccourcis importants / Keybinds

🇫🇷  
- <leader>e — ouvrir/fermer nvim-tree  
- gd — aller à la définition  
- K — documentation hover  
- gr — références  
- <leader>rn — renommer symbole  
- <Tab> / <S-Tab> — naviguer dans l’autocomplétion  
- <leader>bd — fermer buffer  
- <leader>bn / <leader>bv — changer de buffer  

🇬🇧  
- <leader>e — toggle nvim-tree  
- gd — go to definition  
- K — hover documentation  
- gr — references  
- <leader>rn — rename symbol  
- <Tab> / <S-Tab> — completion navigation  
- <leader>bd — close buffer  
- <leader>bn / <leader>bv — cycle buffers  

## Notes

🇫🇷  
Configuration personnelle en évolution continue, pensée pour le développement multi-langages avec une interface moderne.

🇬🇧  
Personal configuration under continuous improvement, optimized for multi-language development with a modern interface.
