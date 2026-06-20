# .hannibal
My dotfiles, crossing the alps into new machines.

## Setup

```sh
./invade
```

`invade` creates symlinks, installs zsh config, and installs vim plugins.

### Prerequisites

- **Starship**: https://starship.rs/
- **Nerd Font**: [BlexMono Nerd Font](https://www.nerdfonts.com/font-downloads) — required for terminal icons
- **fzf**: `brew install fzf` — fast fuzzy finder used in vim
- **ripgrep**: `brew install ripgrep` — used by fzf for file/text search in vim

---

## Vim

`~/.vimrc` and `~/.vim/` are symlinked here. Plugins are managed by
[vim-plug](https://github.com/junegunn/vim-plug), which installs itself
automatically on first launch.

To install/update plugins: `:PlugInstall` / `:PlugUpdate`

### Plugins

| Plugin | Purpose |
|---|---|
| `joshdick/onedark.vim` | Dark colorscheme |
| `itchyny/lightline.vim` | Lightweight status bar (replaces heavy airline) |
| `tpope/vim-vinegar` | Enhances the built-in netrw file browser |
| `preservim/nerdtree` | Side-panel file tree (`<C-n>`) |
| `junegunn/fzf` + `fzf.vim` | Fast fuzzy file/text search |
| `tpope/vim-fugitive` | Full git integration inside vim |
| `airblade/vim-gitgutter` | Shows git diff signs in the gutter |
| `tpope/vim-commentary` | `gcc` to comment/uncomment a line |
| `tpope/vim-surround` | Change/delete surrounding brackets, quotes, tags |

### Key bindings

**Leader key: `,`**

#### File navigation

| Key | Action |
|---|---|
| `<leader>f` | Fuzzy-find files (fzf) |
| `<leader>b` | Search open buffers (fzf) |
| `<leader>/` | Ripgrep across project (fzf); `ctrl-p` toggles preview |
| `<leader>*` | Ripgrep word under cursor |
| `<C-n>` | Toggle NERDTree |
| `<leader>n` | Reveal current file in NERDTree |
| `-` | Open netrw in current file's directory (vim-vinegar) |

#### Windows / splits

| Key | Action |
|---|---|
| `<leader>w` | Open vertical split and jump to it |
| `<C-h/j/k/l>` | Move between splits |

#### Git

| Key | Action |
|---|---|
| `<leader>gs` | Git status (fugitive) |
| `<leader>gd` | Diff current file |
| `<leader>gb` | Git blame |
| `<leader>gl` | Git log (last 20 commits) |
| `<leader>gp` | Git push |
| `]h` / `[h` | Next / previous git hunk |
| `<leader>hs` | Stage hunk under cursor |
| `<leader>hu` | Undo hunk under cursor |
| `<leader>hp` | Preview hunk under cursor |

#### Editing

| Key | Action |
|---|---|
| `gcc` | Comment / uncomment line (vim-commentary) |
| `gc` + motion | Comment region (e.g. `gcip` = comment paragraph) |
| `cs"'` | Change surrounding `"` to `'` (vim-surround) |
| `ds"` | Delete surrounding `"` |
| `ysiw)` | Surround word with `()` |
| `Option-j/k` | Move line(s) down / up |
| `<leader>y` | Yank to system clipboard |
| `<leader>p` | Paste from system clipboard |
| `;` | Enter command mode (same as `:`) |
| `<leader><space>` | Clear search highlight |
| `<leader>ev` | Edit vimrc in a new tab |

### Optional additions

If you want language-specific syntax/LSP support, add these to the plugins block selectively rather than using a large pack like `vim-polyglot`:

```vim
Plug 'pangloss/vim-javascript'     " JavaScript
Plug 'MaxMEllon/vim-jsx-pretty'    " JSX
Plug 'leafgarland/typescript-vim'  " TypeScript
Plug 'dense-analysis/ale'          " Async linting (can be heavy — configure carefully)
```
