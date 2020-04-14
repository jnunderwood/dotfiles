
set undofile
set undolevels=3000
set undoreload=10000
set undodir=~/tmp/nvim/undo/ " undo files
"set undodir=~/.config/nvim/undodir

set backup " keep a backup file
set backupdir=~/tmp/nvim/backup/ " backup files
set directory=~/tmp/nvim/swap/ " swap files

if has('mouse')
  set mouse=a
endif

if has("autocmd")
  augroup vimrcEx
    au!

    " For all text files set 'textwidth' to 78 characters.
    autocmd FileType text setlocal textwidth=108

    " Trim whitespace onsave
    autocmd BufWritePre * %s/\s\+$//e

    " When editing a file, always jump to the last known cursor position.
    " Don't do it when the position is invalid or when inside an event handler
    " (happens when dropping a file on gvim).
    " Also don't do it when the mark is in the first line, that is the default
    " position when opening a file.
    autocmd BufReadPost *
          \ if line("'\"") > 1 && line("'\"") <= line("$") |
          \   exe "normal! g`\"" |
          \ endif

  augroup END
endif " has("autocmd")

" indent and tab stuff
set tabstop=4
set softtabstop=4
set expandtab
set smarttab
set shiftwidth=4
set autoindent
set smartindent

" Unix as standard file type
set fileformats=unix,dos,mac
set fileformat=unix

" Always utf8
set encoding=utf-8
set fileencoding=utf-8
" set termencoding=utf-8

" visualize whitespace; @see also "theme.vimrc"
set list
"set listchars=tab:→\ ,nbsp:␣,trail:•,extends:⟩,precedes:⟨,space:⋅,eol:↲
set listchars=tab:→\ ,nbsp:␣,trail:•,extends:⟩,precedes:⟨
set showbreak=↪\

" clipboard
set clipboard=unnamedplus

set completeopt=longest,menuone,preview

" miscellaneous
set hidden " buffer becomes hidden when abandoned
set magic " for regular expressions
set incsearch
set hlsearch
set number
set ruler " show the cursor position all the time
set wildmenu
set cursorline
set showcmd " display incomplete commands
set nowrap
set ignorecase
"set foldcolumn=4
set nostartofline
set norelativenumber
set number
set concealcursor=""
set conceallevel=0
set modeline
set formatoptions+=j " delete comment character when joining commented lines

" shell
if executable('/usr/bin/zsh')
  set shell=/usr/bin/zsh
else
  set shell=/bin/bash
endif

" detect .md as markdown instead of modula-2
autocmd BufNewFile,BufReadPost *.md set filetype=markdown
"
" stop highlighting of underscores in markdown files
autocmd BufNewFile,BufRead,BufEnter *.md,*.markdown :syntax match markdownIgnore "_"

" add timstamp to backup files
:if !exists("autocommands_loaded")
:  let autocommands_loaded = 1
:  au BufWrite * let &backupext = '-' . strftime("%Y%m%d-%H%M%S") . '~'
:endif

" function to set the working directory to the project's root, or to
" the parent directory of the current file if a root cannot be found
function! s:setcwd()
  let cph = expand('%:p:h', 1)
  if cph =~ '^.\+://' | retu | en
  for mkr in ['.git/', '.hg/', '.svn/', '.bzr/', '_darcs/', '.vimprojects']
    let wd = call('find'.(mkr =~ '/$' ? 'dir' : 'file'), [mkr, cph.';'])
    if wd != '' | let &acd = 0 | brea | en
  endfo
  exe 'lc!' fnameescape(wd == '' ? cph : substitute(wd, mkr.'$', '.', ''))
endfunction
"autocmd BufEnter * call s:setcwd()

" diff -w to ignore whitespace instead of -b
set diffopt+=iwhite
function! DiffW()
  let opt = "-a --binary "
  if &diffopt =~ "icase"  | let opt = opt . "-i " | endif
  if &diffopt =~ "iwhite" | let opt = opt . "-w " | endif " vim uses -b by default
  silent execute "!diff " . opt . v:fname_in . " " . v:fname_new . " > " . v:fname_out
endfunction
set diffexpr=DiffW()

let c_comment_strings=1

" MULTIPURPOSE TAB KEY
" Indent if we're at the beginning of a line. Else, do completion.
function! InsertTabWrapper()
    let col = col('.') - 1
    if !col || getline('.')[col - 1] !~ '\k'
        return "\<tab>"
    else
        return "\<c-p>"
    endif
endfunction

" python
let g:python_host_prog = '/usr/bin/python' " Python 2
let g:python3_host_prog = '/usr/bin/python3' " Python 3

" ripgrep (@see https://gist.github.com/danmikita)
if executable('/usr/bin/rg')
  let $FZF_DEFAULT_COMMAND = '/usr/bin/rg --files --hidden --follow --glob "!.git/*"'
  set grepprg=/usr/bin/rg\ --vimgrep
  command! -bang -nargs=* Find call fzf#vim#grep('/usr/bin/rg --column --line-number --no-heading --fixed-strings --ignore-case --hidden --follow --glob "!.git/*" --color "always" '.shellescape(<q-args>).'| tr -d "\017"', 1, <bang>0)
endif

" Files + devicons (@see https://gist.github.com/danmikita)
function! Fzf_dev()
  let l:fzf_files_options = '--preview "bat --theme="OneHalfDark" --style=numbers,changes --color always {2..-1} | head -'.&lines.'"'

  function! s:files()
    let l:files = split(system($FZF_DEFAULT_COMMAND), '\n')
    return s:prepend_icon(l:files)
  endfunction

  function! s:prepend_icon(candidates)
    let l:result = []
    for l:candidate in a:candidates
      let l:filename = fnamemodify(l:candidate, ':p:t')
      let l:icon = WebDevIconsGetFileTypeSymbol(l:filename, isdirectory(l:filename))
      call add(l:result, printf('%s %s', l:icon, l:candidate))
    endfor

    return l:result
  endfunction

  function! s:edit_file(item)
    let l:pos = stridx(a:item, ' ')
    let l:file_path = a:item[pos+1:-1]
    execute 'silent e' l:file_path
  endfunction

  call fzf#run({
        \ 'source': <sid>files(),
        \ 'sink':   function('s:edit_file'),
        \ 'options': '-m ' . l:fzf_files_options,
        \ 'down':    '40%' })
endfunction
