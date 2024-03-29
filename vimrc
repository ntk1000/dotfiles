" ////////////
" PLUGIN
" ////////////

" use same vimrc for both nvim and vim
call plug#begin('~/.local/share/nvim/plugged')

" color
Plug 'fatih/molokai' " molokai color scheme

" syntax
Plug 'ntk1000/vim-hclfmt' " for hcl
Plug 'godlygeek/tabular' " text filtering and alignment using for vim-markdown
Plug 'plasticboy/vim-markdown' " for markdown
Plug 'cespare/vim-toml' " for toml
Plug 'chase/vim-ansible-yaml' " for ansible yaml
Plug 'ekalinin/Dockerfile.vim' " for Dockerfile
Plug 'corylanou/vim-present' " for go present tool
Plug 'elzr/vim-json' " for json
Plug 'fatih/vim-nginx' " for nginx
Plug 'hashivim/vim-hashicorp-tools' " for hashicorp tools

" tool
Plug 'AndrewRadev/splitjoin.vim' " switcher for oneliner and multiline
Plug 'fatih/vim-go', { 'do': ':GoInstallBinaries' } " go dev plugin for vim
Plug 'tpope/vim-fugitive' " git wrapper tool
Plug 'tpope/vim-commentary' " comment stuff out
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --bin' } " tool like peco
Plug 'junegunn/fzf.vim' "
Plug 'ConradIrwin/vim-bracketed-paste' " automatic :set paste
Plug 'Raimondi/delimitMate' " auto-completion for quotes, parens, brackets, etc.
Plug 'mileszs/ack.vim' " search tool integrate with ag
Plug 'scrooloose/nerdtree' " tree tool
Plug 'lambdalisue/vim-gista' " gist

call plug#end()

" ////////////
" SETTINGS
" ////////////
 
set nocompatible " disable vi compatible, but we dont need in vimrc
set noerrorbells " No beeps
filetype off
filetype plugin indent on

" clipboard http://stackoverflow.com/questions/20186975/vim-mac-how-to-copy-to-clipboard-without-pbcopy
set clipboard^=unnamed
set clipboard^=unnamedplus

" color
syntax enable
set t_Co=256
set background=dark
let g:molokai_original = 1
let g:rehash256 = 1
colorscheme molokai
 
if !has('nvim')
  set ttymouse=xterm2
  set ttyscroll=3
endif

" options
set ttyfast
set laststatus=2 " always show statusline
set encoding=utf-8 " set default encoding to UTF-8
set autoread " automatically reread changed files without asking me anything
set autoindent                  
set backspace=indent,eol,start  " Makes backspace key more powerful.
set incsearch " shows the match while typing
set hlsearch " highlight found searches
set number " show line numbers
set showcmd " show me what I'm typing
set noswapfile " don't use swapfile
set nobackup " don't create annoying backup files
set splitright " split vertical windows right to the current windows
set splitbelow " split horizontal windows below to the current windows
set autowrite " Automatically save before :next, :make etc.
set hidden " set buffer more powerful
set fileformats=unix,dos,mac " Prefer Unix over Windows over OS 9 formats
set noshowmatch " do not show matching brackets by flickering
set noshowmode " show the mode with airline or lightline
set ignorecase " ignore case in search
set smartcase  " ... but not it begins with upper case 
set completeopt=menu,menuone " show completion in pop-up menu
set nocursorcolumn " no highlight in column
set nocursorline " no highlight in line
set updatetime=300 " swap file will be written to disk
set pumheight=10 " completion window max size
set conceallevel=2 " Concealed text is completely hidden
set lazyredraw
 
" " ~/.viminfo needs to be writable and readable
" set viminfo='200
" 
if has('persistent_undo')
  set undofile
  set undodir=~/.cache/vim
endif

" ack with ag
if executable('ag')
  let g:ackprg = 'ag --vimgrep --smart-case'                                                   
endif

 
augroup filetypedetect
"   command! -nargs=* -complete=help Help vertical belowright help <args>
"   autocmd FileType help wincmd L
"   
   autocmd BufNewFile,BufRead .nginx.conf*,nginx.conf* setf nginx
   autocmd BufNewFile,BufRead *.hcl setf conf
   autocmd BufNewFile,BufRead *.go setlocal noexpandtab tabstop=4 shiftwidth=4 
   
"   autocmd BufNewFile,BufRead *.ino setlocal noet ts=4 sw=4 sts=4
   autocmd BufNewFile,BufRead *.txt setlocal noet ts=4 sw=4
   autocmd BufNewFile,BufRead *.md setlocal noet ts=4 sw=4
"   autocmd BufNewFile,BufRead *.html setlocal noet ts=4 sw=4
"   autocmd BufNewFile,BufRead *.vim setlocal expandtab shiftwidth=2 tabstop=2
   autocmd BufNewFile,BufRead *.hcl setlocal expandtab shiftwidth=2 tabstop=2
   autocmd BufNewFile,BufRead *.sh setlocal expandtab shiftwidth=2 tabstop=2
   autocmd BufNewFile,BufRead *.yml setlocal expandtab shiftwidth=2 tabstop=2
   autocmd BufNewFile,BufRead Dockerfile setlocal expandtab shiftwidth=2 tabstop=2
"   autocmd BufNewFile,BufRead *.proto setlocal expandtab shiftwidth=2 tabstop=2
   
   autocmd FileType json setlocal expandtab shiftwidth=2 tabstop=2
   autocmd FileType ruby setlocal expandtab shiftwidth=2 tabstop=2
augroup END

" ////////////
" STATUSLINE
" ////////////
 
let s:modes = {
      \ 'n': 'NORMAL', 
      \ 'i': 'INSERT', 
      \ 'R': 'REPLACE', 
      \ 'v': 'VISUAL', 
      \ 'V': 'V-LINE', 
      \ "\<C-v>": 'V-BLOCK',
      \ 'c': 'COMMAND',
      \ 's': 'SELECT', 
      \ 'S': 'S-LINE', 
      \ "\<C-s>": 'S-BLOCK', 
      \ 't': 'TERMINAL'
      \}

let s:prev_mode = ""
function! StatusLineMode()
  let cur_mode = get(s:modes, mode(), '')

  " do not update higlight if the mode is the same
  if cur_mode == s:prev_mode
    return cur_mode
  endif

  if cur_mode == "NORMAL"
    exe 'hi! StatusLine ctermfg=236'
    exe 'hi! myModeColor cterm=bold ctermbg=148 ctermfg=22'
  elseif cur_mode == "INSERT"
    exe 'hi! myModeColor cterm=bold ctermbg=23 ctermfg=231'
  elseif cur_mode == "VISUAL" || cur_mode == "V-LINE" || cur_mode == "V_BLOCK"
    exe 'hi! StatusLine ctermfg=236'
    exe 'hi! myModeColor cterm=bold ctermbg=208 ctermfg=88'
  endif

  let s:prev_mode = cur_mode
  return cur_mode
endfunction

function! StatusLineFiletype()
  return winwidth(0) > 70 ? (strlen(&filetype) ? &filetype : 'no ft') : ''
endfunction

function! StatusLinePercent()
  return (100 * line('.') / line('$')) . '%'
endfunction

function! StatusLineLeftInfo()
 let branch = FugitiveHead()
 let filename = '' != expand('%:t') ? expand('%:t') : '[No Name]'
 if branch !=# ''
   return printf("%s | %s", branch, filename)
 endif
 return filename
endfunction

exe 'hi! myInfoColor ctermbg=240 ctermfg=252'

" start building our statusline
set statusline=

" mode with custom colors
set statusline+=%#myModeColor#
set statusline+=%{StatusLineMode()}               
set statusline+=%*

" left information bar (after mode)
set statusline+=%#myInfoColor#
set statusline+=\ %{StatusLineLeftInfo()}
set statusline+=\ %*

" go command status (requires vim-go)
set statusline+=%#goStatuslineColor#
set statusline+=%{go#statusline#Show()}
set statusline+=%*

" right section seperator
set statusline+=%=

" filetype, percentage, line number and column number
set statusline+=%#myInfoColor#
set statusline+=\ %{StatusLineFiletype()}\ %{StatusLinePercent()}\ %l:%v
set statusline+=\ %*

" ////////////
" MAPPINGS
" ////////////

" This comes first, because we have mappings that depend on leader
" With a map leader it's possible to do extra key combinations
" i.e: <leader>w saves the current file
let mapleader = ","
 
" Some useful quickfix shortcuts for quickfix
map <C-n> :cn<CR>
map <C-m> :cp<CR>
nnoremap <leader>a :cclose<CR>
 
" " put quickfix window always to the bottom
" augroup quickfix
"     autocmd!
"     autocmd FileType qf wincmd J
"     autocmd FileType qf setlocal wrap
" augroup END
" 
" " Enter automatically into the files directory
" autocmd BufEnter * silent! lcd %:p:h
" 
" " Automatically resize screens to be equally the same
" " autocmd VimResized * wincmd =
" 
" " Fast saving
" nnoremap <leader>w :w!<cr>
" nnoremap <silent> <leader>q :q!<CR>
" 
" " Center the screen
" nnoremap <space> zz
" 
" " Remove search highlight
" nnoremap <leader><space> :nohlsearch<CR>
" 
" " Source the current Vim file
" nnoremap <leader>pr :Runtime<CR>
" 
" " Close all but the current one
" nnoremap <leader>o :only<CR>
" 
" " Better split switching
" map <C-j> <C-W>j
" map <C-k> <C-W>k
" map <C-h> <C-W>h
" map <C-l> <C-W>l
" 
" " Print full path
" map <C-f> :echo expand("%:p")<cr>
" 
" " Terminal settings
" if has('terminal')
"   " Kill job and close terminal window
"   tnoremap <Leader>q <C-w><C-C><C-w>c<cr>
" 
"   " switch to normal mode with esc
"   tnoremap <Esc> <C-W>N
" 
"   " mappings to move out from terminal to other views
"   tnoremap <C-h> <C-w>h
"   tnoremap <C-j> <C-w>j
"   tnoremap <C-k> <C-w>k
"   tnoremap <C-l> <C-w>l
"  
"   " Open terminal in vertical, horizontal and new tab
"   nnoremap <leader>tv :vsplit<cr>:term ++curwin<CR>
"   nnoremap <leader>ts :split<cr>:term ++curwin<CR>
"   nnoremap <leader>tt :tabnew<cr>:term ++curwin<CR>
" 
"   tnoremap <leader>tv <C-w>:vsplit<cr>:term ++curwin<CR>
"   tnoremap <leader>ts <C-w>:split<cr>:term ++curwin<CR>
"   tnoremap <leader>tt <C-w>:tabnew<cr>:term ++curwin<CR>
" 
"   " always start terminal in insert mode when I switch to it
"   " NOTE(arslan): startinsert doesn't work in Terminal-normal mode.
"   " autocmd WinEnter * if &buftype == 'terminal' | call feedkeys("i") | endif
" endif
" 
" " Visual linewise up and down by default (and use gj gk to go quicker)
" noremap <Up> gk
" noremap <Down> gj
" noremap j gj
" noremap k gk
" 
" " Exit on j
" imap jj <Esc>
" 
" " Source (reload configuration)
" nnoremap <silent> <F5> :source $MYNVIMRC<CR>
" 
" nnoremap <F6> :setlocal spell! spell?<CR>
" 
" " Search mappings: These will make it so that going to the next one in a
" " search will center on the line it's found in.
" nnoremap n nzzzv
" nnoremap N Nzzzv
" 
" " Same when moving up and down
" noremap <C-d> <C-d>zz
" noremap <C-u> <C-u>zz
" 
" " Remap H and L (top, bottom of screen to left and right end of line)
" nnoremap H ^
" nnoremap L $
" vnoremap H ^
" vnoremap L g_
" 
" " Act like D and C
" nnoremap Y y$
" 
" 
" " Do not show stupid q: window
" map q: :q
" 
" " Don't move on * I'd use a function for this but Vim clobbers the last search
" " when you're in a function so fuck it, practicality beats purity.
" nnoremap <silent> * :let stay_star_view = winsaveview()<cr>*:call winrestview(stay_star_view)<cr>
" 
" " Time out on key codes but not mappings.
" " Basically this makes terminal Vim work sanely.
" if !has('gui_running')
"   set notimeout
"   set ttimeout
"   set ttimeoutlen=10
"   augroup FastEscape
"     autocmd!
"     au InsertEnter * set timeoutlen=0
"     au InsertLeave * set timeoutlen=1000
"   augroup END
" endif
" 
" " Visual Mode */# from Scrooloose {{{
" function! s:VSetSearch()
"   let temp = @@
"   norm! gvy
"   let @/ = '\V' . substitute(escape(@@, '\'), '\n', '\\n', 'g')
"   let @@ = temp
" endfunction
" 
" vnoremap * :<C-u>call <SID>VSetSearch()<CR>//<CR><c-o>
" vnoremap # :<C-u>call <SID>VSetSearch()<CR>??<CR><c-o>
" 
" " create a go doc comment based on the word under the cursor
" function! s:create_go_doc_comment()
"   norm "zyiw
"   execute ":put! z"
"   execute ":norm I// \<Esc>$"
" endfunction
" nnoremap <leader>ui :<C-u>call <SID>create_go_doc_comment()<CR>
" 
" 
" "===================== PLUGINS ======================
" 
" 
" " ==================== Fugitive ====================
" vnoremap <leader>gb :Gblame<CR>
" nnoremap <leader>gb :Gblame<CR>
" 
" ////////////
" vim-hclfmt
" ////////////
" let g:terraform_fmt_options = " -list=true -diff=true"

" ////////////
" vim-go
" ////////////
let g:go_fmt_fail_silently = 1
let g:go_fmt_command = "goimports"
let g:go_fmt_options = {
  \ 'goimports': '-local do/',
  \ }

let g:go_debug_windows = {
      \ 'vars':  'leftabove 35vnew',
      \ 'stack': 'botright 10new',
\ }


let g:go_sameid_search_enabled = 1

let g:go_test_prepend_name = 1
let g:go_list_type = "quickfix"

let g:go_auto_type_info = 0
let g:go_auto_sameids = 0

let g:go_def_mode = "guru"
let g:go_echo_command_info = 1
let g:go_gocode_autobuild = 1
let g:go_gocode_unimported_packages = 1

let g:go_autodetect_gopath = 1
let g:go_info_mode = "guru"
let g:go_metalinter_autosave_enabled = ['vet', 'golint']
let g:go_highlight_space_tab_error = 0
let g:go_highlight_array_whitespace_error = 0
let g:go_highlight_trailing_whitespace_error = 0
let g:go_highlight_extra_types = 0
let g:go_highlight_build_constraints = 1
let g:go_highlight_types = 0
let g:go_highlight_format_strings = 0

let g:go_modifytags_transform = 'camelcase'
let g:go_fold_enable = []
" 
" nmap <C-g> :GoDecls<cr>
" imap <C-g> <esc>:<C-u>GoDecls<cr>
" 
" run :GoBuild or :GoTestCompile based on the go file
function! s:build_go_files()
  let l:file = expand('%')
  if l:file =~# '^\f\+_test\.go$'
    call go#test#Test(0, 1)
  elseif l:file =~# '^\f\+\.go$'
    call go#cmd#Build(0)
  endif
endfunction

augroup go
  autocmd!

  autocmd FileType go nmap <silent> <Leader>v <Plug>(go-def-vertical)
  autocmd FileType go nmap <silent> <Leader>s <Plug>(go-def-split)
  autocmd FileType go nmap <silent> <Leader>d <Plug>(go-def-tab)
  autocmd FileType go nmap <silent> <Leader>p <Plug>(go-def-pop)
  autocmd FileType go nmap <silent> <Leader>s <Plug>(go-def-stack)

  autocmd FileType go nmap <silent> <Leader>x <Plug>(go-doc-vertical)

  autocmd FileType go nmap <silent> <Leader>i <Plug>(go-info)
  autocmd FileType go nmap <silent> <Leader>l <Plug>(go-metalinter)

  autocmd FileType go nmap <silent> <leader>b :<C-u>call <SID>build_go_files()<CR>
  autocmd FileType go nmap <silent> <leader>t  <Plug>(go-test)
  autocmd FileType go nmap <silent> <leader>r  <Plug>(go-run)
  autocmd FileType go nmap <silent> <leader>e  <Plug>(go-install)

  autocmd FileType go nmap <silent> <Leader>c <Plug>(go-coverage-toggle)

  " I like these more!
  autocmd Filetype go command! -bang A call go#alternate#Switch(<bang>0, 'edit')
  autocmd Filetype go command! -bang AV call go#alternate#Switch(<bang>0, 'vsplit')
  autocmd Filetype go command! -bang AS call go#alternate#Switch(<bang>0, 'split')
  autocmd Filetype go command! -bang AT call go#alternate#Switch(<bang>0, 'tabe')
augroup END
 
 
" " ==================== FZF ====================
" let g:fzf_command_prefix = 'Fzf'
" let g:fzf_layout = { 'down': '~20%' }
" 
" nmap <C-p> :FzfHistory<cr>
" imap <C-p> <esc>:<C-u>FzfHistory<cr>
" 
" nmap <C-b> :FzfFiles<cr>
" imap <C-b> <esc>:<C-u>FzfFiles<cr>
" 
" let g:rg_command = '
"   \ rg --column --line-number --no-heading --fixed-strings --ignore-case --no-ignore --hidden --follow --color "always"
"   \ -g "*.{js,json,php,md,styl,jade,html,config,py,cpp,c,go,hs,rb,conf}"
"   \ -g "!{.git,node_modules,vendor}/*" '
" 
" command! -bang -nargs=* Rg
"   \ call fzf#vim#grep(
"   \   'rg --column --line-number --no-heading --color=always '.shellescape(<q-args>), 1,
"   \   <bang>0 ? fzf#vim#with_preview('up:60%')
"   \           : fzf#vim#with_preview('right:50%:hidden', '?'),
"   \   <bang>0)
" 
" command! -bang -nargs=* F call fzf#vim#grep(g:rg_command .shellescape(<q-args>), 1, <bang>0)
" 
" " ==================== delimitMate ====================
" let g:delimitMate_expand_cr = 1   
" let g:delimitMate_expand_space = 1    
" let g:delimitMate_smart_quotes = 1    
" let g:delimitMate_expand_inside_quotes = 0    
" let g:delimitMate_smart_matchpairs = '^\%(\w\|\$\)'   
" 
" imap <expr> <CR> pumvisible() ? "\<c-y>" : "<Plug>delimitMateCR"
 
" ////////////
" NERDTree
" ////////////

" For toggling
noremap <Leader>n :NERDTreeToggle<cr>
noremap <Leader>f :NERDTreeFind<cr>

let NERDTreeShowHidden=1

 
" ////////////
" markdown
" ////////////

let g:vim_markdown_folding_disabled = 1 " disable folding
let g:vim_markdown_new_list_item_indent = 2
let g:vim_markdown_fenced_languages = ['go=go', 'viml=vim', 'bash=sh']
let g:vim_markdown_toml_frontmatter = 1
let g:vim_markdown_frontmatter = 1
let g:vim_markdown_no_extensions_in_markdown = 1
 
 
" " ==================== vim-json ====================
" let g:vim_json_syntax_conceal = 0
" 
" " ==================== UltiSnips ====================
" function! g:UltiSnips_Complete()
"   call UltiSnips#ExpandSnippet()
"   if g:ulti_expand_res == 0
"     if pumvisible()
"       return "\<C-n>"
"     else
"       call UltiSnips#JumpForwards()
"       if g:ulti_jump_forwards_res == 0
"         return "\<TAB>"
"       endif
"     endif
"   endif
"   return ""
" endfunction
" 
" function! g:UltiSnips_Reverse()
"   call UltiSnips#JumpBackwards()
"   if g:ulti_jump_backwards_res == 0
"     return "\<C-P>"
"   endif
" 
"   return ""
" endfunction
" 
" 
" if !exists("g:UltiSnipsJumpForwardTrigger")
"   let g:UltiSnipsJumpForwardTrigger = "<tab>"
" endif
" 
" if !exists("g:UltiSnipsJumpBackwardTrigger")
"   let g:UltiSnipsJumpBackwardTrigger="<s-tab>"
" endif
" 
" au InsertEnter * exec "inoremap <silent> " . g:UltiSnipsExpandTrigger . " <C-R>=g:UltiSnips_Complete()<cr>"
" au InsertEnter * exec "inoremap <silent> " . g:UltiSnipsJumpBackwardTrigger . " <C-R>=g:UltiSnips_Reverse()<cr>"
" 
" " ==================== Various other plugin settings ====================
" nmap  -  <Plug>(choosewin)
" 
" " Trigger a highlight in the appropriate direction when pressing these keys:
" let g:qs_highlight_on_keys = ['f', 'F', 't', 'T']
" 
" " vim: sw=2 sw=2 et
