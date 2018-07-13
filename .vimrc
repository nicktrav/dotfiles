" -----------------------------------------------------------------------------
"   Plugins
" -----------------------------------------------------------------------------
" If vundle is not installed, do it first
if (!isdirectory(expand("$HOME/.vim/repos/github.com/Shougo/dein.vim")))
  call system(expand("mkdir -p $HOME/.vim/repos/github.com"))
  call system(expand("git clone https://github.com/Shougo/dein.vim $HOME/.vim/repos/github.com/Shougo/dein.vim"))
endif

set nocompatible
set runtimepath+=~/.vim/repos/github.com/Shougo/dein.vim/

call dein#begin(expand('~/.vim'))
  let pluginsExist = 0
  call dein#add('Shougo/dein.vim')
  call dein#add('airblade/vim-gitgutter')
  call dein#add('tpope/vim-fugitive')
  call dein#add('tpope/vim-unimpaired')
  call dein#add('scrooloose/syntastic')
  call dein#add('christoomey/vim-tmux-navigator')
  call dein#add('tmux-plugins/vim-tmux')
  call dein#add('tmux-plugins/vim-tmux-focus-events')
  call dein#add('ujihisa/unite-colorscheme')
  call dein#add('vim-airline/vim-airline')
  call dein#add('vim-airline/vim-airline-themes')
  call dein#add('vimwiki/vimwiki')
  call dein#add('scrooloose/nerdtree')
  call dein#add('Shougo/unite.vim')
  call dein#add('ngmy/vim-rubocop')
  call dein#add('Shougo/vimproc.vim', {'build' : 'make'})
  call dein#add('Shougo/unite.vim')
  call dein#add('junegunn/goyo.vim')
  call dein#add('junegunn/fzf', { 'build': './install --all', 'merged': 0 })
  call dein#add('junegunn/fzf.vim', { 'depends': 'fzf' })
  call dein#add('rainglow/vim')
  call dein#add('edkolev/tmuxline.vim')
  call dein#add('rust-lang/rust.vim')
  call dein#add('majutsushi/tagbar')
  if dein#check_install()
    call dein#install()
  endif
call dein#end()

" -----------------------------------------------------------------------------
"   Mappings
" -----------------------------------------------------------------------------

" Find files with fzf
nmap <Leader>t :Files<CR>
nmap <Leader>b :Buffers<CR>

" Search contents of files with ripgrep
command! -bang -nargs=* Find call fzf#vim#grep('rg --column --line-number --no-heading --fixed-strings --ignore-case --no-ignore --hidden --follow --glob "!.git/*" --color "always" '.shellescape(<q-args>), 1, <bang>0)
nmap <Leader>f :Find<CR>

" Distraction free editing
nmap <Leader>G :Goyo<CR>

" Turning off arrow key - beacuse that's just lazy
noremap <Up> <NOP>
noremap <Down> <NOP>
noremap <Left> <NOP>
noremap <Right> <NOP>

" Close a buffer by first switching to the next buffer and then closing out
" the buffer from which we came
nnoremap c :bp\|bd #<CR>

" Remap semicolon to colon
nnoremap ; :

" Remap the nav keys to move around splits
nnoremap <C-J> <C-W><C-J>
nnoremap <C-K> <C-W><C-K>
nnoremap <C-L> <C-W><C-L>
nnoremap <C-H> <C-W><C-H>

" -----------------------------------------------------------------------------
"   Layout
" -----------------------------------------------------------------------------
" Highlight current line
set cursorline

" Tab settings
filetype plugin indent on
set tabstop=2
set shiftwidth=2
set expandtab

" Sensible splitting
set splitbelow
set splitright

" better searching
set incsearch
set hlsearch
nmap <leader>h :nohlsearch<cr>
set ignorecase
set smartcase

" Line numbers
set relativenumber
set number

" Toggle between relative and absolute numbering
function! NumberToggle()
  if(&relativenumber == 1)
    set norelativenumber
    set number
  else
    set relativenumber
  endif
endfunc
nnoremap <C-n> :call NumberToggle()<cr>

set clipboard=unnamed

" Remember cursor position between vim sessions
autocmd BufReadPost *
  \ if line("'\"") > 0 && line ("'\"") <= line("$") |
  \   exe "normal! g'\"" |
  \ endif

" Center buffer around cursor when opening files
autocmd BufRead * normal zz

" -----------------------------------------------------------------------------
"   Unite
" -----------------------------------------------------------------------------
let g:unite_source_history_yank_enable=1
let g:unite_prompt='»'

" Don't skip the first line when navigating
let g:unite_enable_auto_select = 0

" Find files by content
let g:unite_source_grep_command = 'ag'
let g:unite_source_grep_default_opts = '--nocolor --nogroup --hidden --ignore .git --ignore .svn --ignore .class'
let g:unite_source_grep_recursive_opt = ''

autocmd FileType unite call s:unite_settings()
function! s:unite_settings()
  " Close with escape
  nnoremap <ESC> :UniteClose<cr>

  " Enable navigation with Control-j and Control-k in insert mode
  imap <buffer> <C-j>   <Plug>(unite_select_next_line)
  imap <buffer> <C-k>   <Plug>(unite_select_previous_line)
endfunction

" Git
let g:unite_source_menu_menus = {} " Useful when building interfaces at appropriate places
let g:unite_source_menu_menus.git = {
  \ 'description' : 'Fugitive interface',
  \}
let g:unite_source_menu_menus.git.command_candidates = [
  \[' git status', 'Gstatus'],
  \[' git diff', 'Gvdiff'],
  \[' git commit', 'Gcommit'],
  \[' git stage/add', 'Gwrite'],
  \[' git checkout', 'Gread'],
  \[' git rm', 'Gremove'],
  \[' git cd', 'Gcd'],
  \[' git push', 'exe "Git! push " input("remote/branch: ")'],
  \[' git pull', 'exe "Git! pull " input("remote/branch: ")'],
  \[' git pull rebase', 'exe "Git! pull --rebase " input("branch: ")'],
  \[' git checkout branch', 'exe "Git! checkout " input("branch: ")'],
  \[' git fetch', 'Gfetch'],
  \[' git merge', 'Gmerge'],
  \[' git browse', 'Gbrowse'],
  \[' git head', 'Gedit HEAD^'],
  \[' git parent', 'edit %:h'],
  \[' git log commit buffers', 'Glog --'],
  \[' git log current file', 'Glog -- %'],
  \[' git log last n commits', 'exe "Glog -" input("num: ")'],
  \[' git log first n commits', 'exe "Glog --reverse -" input("num: ")'],
  \[' git log until date', 'exe "Glog --until=" input("day: ")'],
  \[' git log grep commits',  'exe "Glog --grep= " input("string: ")'],
  \[' git log pickaxe',  'exe "Glog -S" input("string: ")'],
  \[' git index', 'exe "Gedit " input("branchname\:filename: ")'],
  \[' git mv', 'exe "Gmove " input("destination: ")'],
  \[' git grep',  'exe "Ggrep " input("string: ")'],
  \[' git prompt', 'exe "Git! " input("command: ")'],
  \] " Append ' --' after log to get commit info commit buffers
nnoremap <silent> <Leader>g :Unite -direction=botright -silent -buffer-name=git -start-insert menu:git<CR>

" -----------------------------------------------------------------------------
"   NERDTree
" -----------------------------------------------------------------------------
" Autostart NERDTree in the main window.
autocmd VimEnter * NERDTree
autocmd VimEnter * wincmd p

" Allow backspace in insert mode
:set backspace=2

" Show hidden files by default
let NERDTreeShowHidden=1
set laststatus=2

" -----------------------------------------------------------------------------
"   Syntastic
" -----------------------------------------------------------------------------
set statusline+=%#warningmsg#
set statusline+=%{SyntasticStatuslineFlag()}
set statusline+=%*

let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list = 1
let g:syntastic_check_on_open = 1
let g:syntastic_check_on_wq = 0

" -----------------------------------------------------------------------------
"   Fugitive
" -----------------------------------------------------------------------------
set statusline+=%{fugitive#statusline()}

" -----------------------------------------------------------------------------
"   Rust
" -----------------------------------------------------------------------------
nmap <Leader>r :TagbarToggle<CR>
autocmd BufRead *.rs :setlocal tags=./rusty-tags.vi;/,$RUST_SRC_PATH/rusty-tags.vi
autocmd BufWritePost *.rs :silent! exec "!rusty-tags vi --quiet --start-dir=" . expand('%:p:h') . "&" | redraw!

" -----------------------------------------------------------------------------
"   Themes and colors
" -----------------------------------------------------------------------------
syntax enable
set termguicolors
colorscheme Tomorrow-Night
set t_ut= " without this line, weird things happen when using tmux

" vim-airline
let g:airline#extensions#tabline#enabled = 1
set hidden
let g:airline#extensions#tabline#fnamemod = ':t'
let g:airline#extensions#tabline#show_tab_nr = 1
let g:airline_powerline_fonts = 1
let g:airline_theme='minimalist'

" Colouring for greater than 80 chars
highlight ColorColumn ctermbg=Red
call matchadd('ColorColumn', '\%81v', 100)

" Highlight whitespace and tabs
exec "set listchars=tab:\uBB\uBB,trail:\uB7,nbsp:~"
set list
" -----------------------------------------------------------------------------
"   Spelling
" -----------------------------------------------------------------------------
" Turn on spelling for markdown files
autocmd BufRead,BufNewFile *.md setlocal spell complete+=kspell

" Highlight bad words in red
autocmd BufRead,BufNewFile *.md hi SpellBad guibg=#ff2929 guifg=#ffffff" ctermbg=224
