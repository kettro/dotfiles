" Vundle
set nocompatible
filetype off
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()

Plugin 'VundleVim/Vundle.vim'
Plugin 'tpope/vim-fugitive'
Plugin 'tpope/vim-abolish'
Plugin 'colorsupport.vim'
Plugin 'Indent-Guides'
"Plugin 'Valloric/YouCompleteMe'
Plugin 'flazz/vim-colorschemes'
Plugin 'scrooloose/nerdtree'
Plugin 'ctrlpvim/ctrlp.vim'
Plugin 'powerline/powerline'
Plugin 'mileszs/ack.vim'
Plugin 'tpope/vim-eunuch'
Plugin 'godlygeek/tabular'
Plugin 'scrooloose/syntastic'
Plugin 'Raimondi/delimitMate'
if has("lua") == 1
  Plugin 'shougo/neocomplete.vim'
else
  Plugin 'AutoComplPop'
endif
Plugin 'vim-ruby/vim-ruby'
"Plugin 'c.vim'
Plugin 'justinmk/vim-syntax-extra'

call vundle#end()
filetype plugin indent on

" Editor Options
syntax enable
set showcmd
set number
set scrolloff=15
set visualbell
set backspace=indent,eol,start
set mouse=a
set ruler
set laststatus=2
set ttyfast
set ttymouse=xterm2
let mapleader="\\"
set cursorline

" Mode Management
inoremap qq <Esc>
nnoremap ; :
noremap <C-;> <Esc>

" Whitespace
set list
set listchars=tab:>=,trail:·,extends:>,precedes:<,nbsp:·
autocmd BufWritePre * :%s/\s+$//e
nnoremap <Enter><Enter> o<Esc>k

" Tabbing
filetype indent on
vnoremap <Tab> > indent on SwitchToNex
vnoremap <S-Tab> <
inoremap <S-Tab> <Esc><<i
set smarttab
set expandtab
set tabstop=2
set shiftwidth=2
set autoindent

" Buffers
cnoremap ls ls!
nnoremap <silent> <Tab> :call SwitchToNextBuffer(1)<cr>:ls!<cr>:echo "To Next Buffer"<cr>
nnoremap <silent> <S-Tab> :call SwitchToNextBuffer(-1)<cr>:ls!<cr>:echo "To Previous Buffer"<cr>

" Wildmenu
set wildmenu

" Functions
function! SwitchToNextBuffer(incr)
  let help_buffer = (&filetype == 'help')
  let current = bufnr("%")
  let last = bufnr("$")
  let new = current + a:incr
  while 1
    if new != 0 && bufexists(new) && ((getbufvar(new, "&filetype") == 'help') == help_buffer)
      execute ":buffer ".new
      break
    else
      let new = new + a:incr
      if new < 1
        let new = last
      elseif new > last
        let new = 1
      endif
      if new == current
        break
      endif
    endif
  endwhile
endfunction

" Background Colors
autocmd VimEnter * :colorscheme molokai
autocmd VimEnter * :hi clear CursorLine

set t_ut=

" Indent Guides
let g:indent_guides_guide_size = 0
let g:indent_guides_start_level = 2
let g:indent_guides_color_change_percent = 10
let g:indent_guides_exclude_filetype = ['help', 'nerdtree']
let g:indent_guides_auto_colors = 0
let g:indent_guides_enable_on_vim_startup = 1
hi IndentGuidesOdd ctermbg=235
hi IndentGuidesEven ctermbg=234

" Syntastic
set statusline+=%#warningmsg#
set statusline+=%{SyntasticStatuslineFlag()}
set statusline+=%*
let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list = 1
let g:syntastic_check_on_open = 1
let g:syntastic_check_on_wq = 0
let g:syntastic_c_include_dirs = ['../include', 'include', '../inc', 'inc']

" AutoComplPop && neocomplete
 if has("lua") == 1
  let g:acp_enableAtStartup = 0
  let g:neocomplete#enable_auto_select = 1
  let g:neocomplete#enable_at_startup = 1
  let g:neocomplete#enable_smart_case = 1
  let g:neocomplete#sources#syntax#min_keyword_length = 3
  inoremap <expr><C-g> neocomplete#undo_completion()
  inoremap <expr><C-l> neocomplete#complete_common_string()
  inoremap <expr><TAB> pumvisible() ? "\<C-n>" : "\<TAB>"
  inoremap <expr><BS> neocomplete#smart_close_popup()."\<C-h>"
  inoremap <expr><C-h> neocomplete#smart_close_popup()."\<C-h>"
  inoremap <silent> <CR> <C-r>=<SID>neocomplete_CR()
  function! s:neocomplete_CR()
    return (pumvisible() ? "\<C-y>" : "" ) . "\<CR>"\<CR>
  endfunction
  let g:neocomplete#enable_auto_select = 1
endif
