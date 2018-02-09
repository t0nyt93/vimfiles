"Basic Vundle Setup
set nocompatible
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()
"Of course we need to use Vundle.
Plugin 'VundleVim/Vundle.vim'
Plugin 'git://git.wincent.com/command-t.git'
Plugin 'tpope/vim-fugitive'
Plugin 'Valloric/YouCompleteMe'
Plugin 'ternjs/tern_for_vim'
Plugin 'w0rp/ale'
Plugin 'rking/ag.vim'
Plugin 'raimondi/delimitMate'
Plugin 'moll/vim-node'
Plugin 'airblade/vim-gitgutter'
Plugin 'othree/javascript-libraries-syntax'
Plugin 'scrooloose/nerdtree'
Plugin 'majutsushi/tagbar'
Plugin 'gavocanov/vim-js-indent'
Plugin 'jonathanfilip/vim-lucius'
Plugin 'heavenshell/vim-jsdoc'
call vundle#end()

"------------- Gui Stuff --------------------
set guifont=Monofur:h16
set number
"Let specify some default colors just for shits and giggles
colorscheme lucius
LuciusDark

"Set out title of the tab to our current working directory.
set titlestring=%{substitute(getcwd(),\ $HOME,\ '~',\ '')}

"Lets take care of some pesky tab completion for files.
set wildmode=longest,list,full
set wildignore+=*/coverage,*/node_modules
set wildmenu
"--------------------------------------------
"--- Swapfiles can go fuckkk themselves
set noswapfile
set backupdir=~/.vim/backup/
set directory=~/.vim/swap/
set undodir=~/.vim/undo/
"--------
"Reload vimRC on file changes saved
augroup reload_vimrc " {
    autocmd!
    autocmd BufWritePost $MYVIMRC source $MYVIMRC
augroup END " }
" Please help me format Javascript...
autocmd Filetype javascript setlocal equalprg=js-beautify\ --stdin

"Set some basic formatting
set tabstop=4
set shiftwidth=4
set smartindent
set autoindent
set expandtab
set wrap!

"remove trailing white space on file save does this on all files
augroup ClearWhitespace
    autocmd!
    autocmd BufWritePre * silent :%s/\s\+$//e
augroup END

"LINE NUMBERING LOGIC
"" Sort of copying the logic from the Vim numbertoggle plugin
augroup numbers
    autocmd!
    au FocusLost,WinLeave,InsertEnter * setlocal norelativenumber
    au FocusGained,WinEnter,InsertLeave *  setlocal relativenumber
augroup END

"GENERATING JS-CTAGS for easy navigation
nnoremap <leader>td :TernDef<CR>
nnoremap <leader>tr :TernRefs<CR>
nnoremap <leader>tt :TernType<CR>
nnoremap <leader>tr :TernRename<CR>

"This may collide with something jsctags is trying to use...
" Some shit to help with switching tabs
nnoremap <Leader>w <C-w>w
nnoremap <Leader>q <C-^>
nnoremap <Leader>o <C-o>
nnoremap <Leader>i <C-i>

"---------------------------Plugin Settings --------------------------
"------- Nerdtree
map <Leader>t :NERDTreeToggle<CR>
"-----------------
"------- othree syntax
let g:used_javascript_libs = 'lo-dash,chai,jasmine'
"-----------------
"------- You.... YouCompleteMe.
let g:ycm_add_preview_to_completeopt=0
let g:ycm_confirm_extra_conf=0
"-----------------
"------- Command T
nmap <silent> <Leader>p <Plug>(CommandT)
"-----------------
"------- Tagbar
nmap <silent> <Leader>b :TagbarToggle<CR>
"-----------------
"-------------------- Vim-Node -------------
"Remaps the <C-w>f command to open in vertical split by default.
autocmd User Node
  \ if &filetype == "javascript" |
  \   nmap <buffer> <C-w>f <Plug>NodeVSplitGotoFile |
  \   nmap <buffer> <C-w><C-f> <Plug>NodeVSplitGotoFile |
  \ endif
"--------------------------------------------
"{{{ JSCtags
nnoremap <silent><F4> :find ./node -name "*.js" -not -path "./node/node_modules/*" -exec jsctags {} -f \; <bar> sed '/^&/d' <bar> sort > tags<CR>
"}}}

"{{{ ALE
let g:ale_sign_column_always = 1
let g:ale_sign_error = '>>'
let g:ale_sign_warning = '--'
let g:ale_linters = {
\    'javascript': ['eslint', 'jshint'],
\}
let g:ale_pattern_options = {
\   '.*\.json$': {'ale_enabled': 1},
\   '.*\.js$': {'ale_enabled': 1}
\}
"}}}
" vim-jsdocs
nmap <silent> <Leader>c <Plug>(jsdoc)
"----------

"-------- DelimitMate
let g:delimitMate_expand_cr = 1
let g:delimitMate_expand_space = 1
"--------------------
"}}}

