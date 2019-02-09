"""""""""""""""""""""""""""""""""""""""
" Plugin functions
"""""""""""""""""""""""""""""""""""""""
function! BuildComposer(info)
  if a:info.status != 'unchanged' || a:info.force
    if has('nvim')
      !cargo build --release
    else
      !cargo build --release --no-default-features --features json-rpc
    endif
  endif
endfunction
"""""""""""""""""""""""""""""""""""""""
" Plugins
"""""""""""""""""""""""""""""""""""""""
if empty(glob('~/.local/share/nvim/site/autoload/plug.vim'))
  silent !curl -fLo ~/.local/share/nvim/site/autoload/plug.vim --create-dirs
    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif
call plug#begin()
Plug 'bling/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug '907th/vim-auto-save'
" colorschemes
Plug 'drewtempelmeyer/palenight.vim'
"
Plug 'wincent/ferret'
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'junegunn/fzf.vim'
Plug 'wincent/loupe'
Plug 'plasticboy/vim-markdown'
Plug 'mzlogin/vim-markdown-toc'
Plug 'euclio/vim-markdown-composer', { 'do': function('BuildComposer') }
"Plug 'gabrielelana/vim-markdown'
"Plug 'SidOfc/mkdx'
Plug 'scrooloose/nerdtree'
"Plug 'vim-pandoc/vim-pandoc'
"Plug 'vim-pandoc/vim-pandoc-syntax'
Plug 'tpope/vim-repeat' " repeats plug-in actions with .
Plug 'tpope/vim-surround'
Plug 'majutsushi/tagbar'
Plug 'christoomey/vim-tmux-navigator'
Plug 'vim-voom/voom'
call plug#end()

"""""""""""""""""""""""""""""""""""""""
" Plugin settings
"""""""""""""""""""""""""""""""""""""""
" airline
" let airline show open buffers
let g:airline#extensions#tabline#enabled = 1
" let airline use powerline fonts
let g:airline_powerline_fonts = 1
" stop whitespace check for now - slows moving around
let g:airline#extensions#whitespace#enabled = 0
" avoid bright yellow normal mode indicators
let g:airline_theme='deus'

" auto-save
let g:auto_save = 1  " enable AutoSave on Vim startup

" colorschemes
colorscheme palenight
let g:palenight_terminal_italics=1
set background=dark

" fzf
" https://www.reddit.com/r/neovim/comments/3oeko4/post_your_fzfvim_configurations/
nnoremap <silent> <leader>f :Files<CR>
nnoremap <silent> <leader>b :Buffers<CR>

" loupe
" provides better in-file search
" https://github.com/wincent/loupe
" sets 'magic' (perl/ruby-like) regexes by default
" http://vim.wikia.com/wiki/Simplifying_regular_expressions_using_magic_and_no-magic
" Instead of <leader>n, use <leader>x, since we're using \n for NERDTree
nmap <leader>x <Plug>(LoupeClearHighlight)

" markdown (plasticboy)
set conceallevel=2
let g:vim_markdown_no_extensions_in_markdown = 1 " assume .md for following links
let g:vim_markdown_follow_anchor = 1 " allow following internal # links
let g:vim_markdown_auto_insert_bullets = 0
let g:vim_markdown_new_list_item_indent = 0

" markdown (mkdx)
"let g:mkdx#settings = { 'highlight': { 'enable': 1 },
"  \ 'enter': { 'shift': 1 },
"  \ 'links': { 'external': { 'enable': 1 } },
"  \ 'fold': { 'enable': 1 } }

" markdown (pandoc)
" conceal links
" let g:pandoc#syntax#conceal#urls = 1

" markdown-toc
" https://github.com/mzlogin/vim-markdown-toc
" update TOC manually, since with autosave we're slowing things down
" generating the TOC too often and having the cursor jump around
nnoremap <leader>ut :UpdateToc<CR>
let g:vmt_auto_update_on_save = 0

" nerdtree
nnoremap <leader>n :NERDTreeToggle<CR>

" tagbar
nnoremap <leader>t :TagbarToggle<CR>

" voom
let g:voom_python_versions = [3,2]
let g:voom_default_mode = 'markdown'
let g:voom_tree_placement = "right"
nnoremap <LocalLeader>v :VoomToggle<CR>

"""""""""""""""""""""""""""""""""""""""
" keymap customisations
"""""""""""""""""""""""""""""""""""""""
" get out of the insert mode with jk
inoremap kj <esc>

" switch between split windows quickly with ^<h|j|k|l>
nnoremap <C-J> <C-W><C-J>
nnoremap <C-K> <C-W><C-K>
nnoremap <C-L> <C-W><C-L>
nnoremap <C-H> <C-W><C-H>
" move to last pane quickly
nnoremap <C-P> <C-W><C-P>

" have space toggle folds, not just open them
noremap <Space> za

" use \z to zoom current pane to new tab, with :wq to exit the tab.  See:
" See https://forum.upcase.com/t/vim-switch-one-window-to-full-screen/4356
nnoremap <silent> <leader>z :tabnew %<CR>

" Tab navigation like Chrome
" http://vim.wikia.com/wiki/Alternative_tab_navigation
" unfortunately only the last of these works in the terminal!
nnoremap <C-S-tab> :tabprevious<CR>
nnoremap <C-tab>   :tabnext<CR>
nnoremap <C-t>     :tabnew<CR>
inoremap <C-S-tab> <Esc>:tabprevious<CR>i
inoremap <C-tab>   <Esc>:tabnext<CR>i
inoremap <C-t>     <Esc>:tabnew<CR>

"""""""""""""""""""""""""""""""""""""""
" leader customisations
"""""""""""""""""""""""""""""""""""""""
" use \q as a way to close the current buffer without closing the window
nnoremap <silent> <leader>q :lclose<bar>b#<bar>bd #<CR>

"""""""""""""""""""""""""""""""""""""""
" behaviour customizations
"""""""""""""""""""""""""""""""""""""""
" use j and k in the omnicomplete list,
" to avoid confusion about Enter vs C-y to select an option, from:
" https://unix.stackexchange.com/questions/162528/select-an-item-in-vim-autocomplete-list-without-inserting-line-break
inoremap <expr> j ((pumvisible())?("\<C-n>"):("j"))
inoremap <expr> k ((pumvisible())?("\<C-p>"):("k"))

" open new splits to right and bottom, instead of vim default
set splitbelow
set splitright

" Trigger `autoread` when files changes on disk
" https://unix.stackexchange.com/questions/149209/refresh-changed-content-of-file-opened-in-vim/383044#383044
" https://vi.stackexchange.com/questions/13692/prevent-focusgained-autocmd-running-in-command-line-editing-mode
autocmd FocusGained,BufEnter,CursorHold,CursorHoldI * if mode() != 'c' | checktime | endif
" Notification after file change
" https://vi.stackexchange.com/questions/13091/autocmd-event-for-autoread
autocmd FileChangedShellPost *
  \ echohl WarningMsg | echo "File changed on disk. Buffer reloaded." | echohl None

" Use Ctrl mappings to move lines left and right,
" unfortunately it needs a little vimwiki suppression.
nnoremap <C-Right> >>
nnoremap <C-Left> <<
inoremap <C-Right> <C-T>
inoremap <C-Left> <C-D>
vnoremap <C-Right> >
vnoremap <C-Left> <
nnoremap <C-Up> ddkP
nnoremap <C-Down> ddp
inoremap <C-Up> <esc>ddkP
inoremap <C-Down> <esc>ddP

" indenting
set tabstop=2
set shiftwidth=2 " indent size
set expandtab " don't use tab characters
set smartindent " does the right thing (mostly) in programs

"""""""""""""""""""""""""""""""""""""""
" WSL-specific settings
"""""""""""""""""""""""""""""""""""""""
" enable launching web links from Vim in WSL with command 'gx'
" from https://superuser.com/questions/1314581/open-url-with-vim-in-ubuntu-wsl-windows-subsystem-for-linux
if !empty(glob('~/os_is_wsl'))
  " have gx do the right thing with links
  let g:netrw_browsex_viewer = "cmd.exe /C start"
  " open current file in browser with gb
  nnoremap <silent> gb :!cmd.exe /C "start % &"<CR><CR>
  " old version that worked on vim not nvim
  "nmap <silent> <leader>wo :exe '!cmd.exe /C start % &'<CR> 
  " start in the vimwiki dir
  cd ~/org/wiki
endif

"""""""""""""""""""""""""""""""""""""""
" Linux-specific settings
"""""""""""""""""""""""""""""""""""""""
" enable launching web links from Vim in WSL with command 'gx'
" from https://superuser.com/questions/1314581/open-url-with-vim-in-ubuntu-wsl-windows-subsystem-for-linux
if !empty(glob('~/os_is_linux'))
  " open current file in browser with gb - as yet untested
  nnoremap gb :exe ':silent !chromium-browser % '<CR>
endif
