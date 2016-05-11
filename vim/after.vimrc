" after.vimrc - settings applied after vimrc is processed

" override default vimified settings {{{
"    ~/.vim/vimrc as of 2014-09-09
"

" override lines 329-334 (re-enable arrow keys)
nmap <left>  h
nmap <up>    k
nmap <down>  j
nmap <right> l

" override line 398 (removed eol char)
set listchars=tab:▸\ ,extends:❯,precedes:❮,trail:␣

" override line 642 (vimrc) and line 16 (~/.vim/functions/my_fold_text.vim)
" reset foldtext method to default instead of MyFoldText()
set foldtext=foldtext()

set modelines=5      " override line 418
set norelativenumber " override line 421
set textwidth=0      " override line 442
set nowrap           " override line 445
set colorcolumn=0    " override line 448
set novisualbell     " override line 452

" override lines 560-562
" Splits ,sv and ,sh to open new splits (vertical and horizontal)
unmap <leader>v
unmap <leader>h
nnoremap <leader>sv <C-w>v<C-w>l
nnoremap <leader>sh <C-w>s<C-w>j

" override line 375
iunabbrev z@

" override lines 540-542
unmap H
unmap L

" override lines 470-479
set cursorline
augroup cline
    au!
    au WinLeave    * set cursorline
    au WinEnter    * set cursorline
    au InsertEnter * set cursorline
    au InsertLeave * set cursorline
augroup END

"
" }}}

" performance improvement settings {{{
"
" @see http://stackoverflow.com/questions/4775605/vim-syntax-highlight-improve-performance
" @see http://vim.wikia.com/wiki/Fix_syntax_highlighting
"

"syntax sync minlines=256
set nocursorcolumn
" set nocursorline  " set above

"
" }}}

" miscellaneous settings {{{
"

let c_comment_strings=1

" next and previous tabs
noremap <C-tab>   :tabnext<CR>
noremap <C-S-tab> :tabprevious<CR>

" quick edits
"nnoremap <leader>ev <C-w>s<C-w>j:e ~/.vim/vimrc  " already set in .vimrc
nnoremap <leader>ev  <ESC>:e ~/dotfiles/vim/vimrc
nnoremap <leader>eva <ESC>:e ~/dotfiles/vim/after.vimrc
nnoremap <leader>eve <ESC>:e ~/dotfiles/vim/extra.vimrc
nnoremap <leader>eb  <ESC>:e ~/dotfiles/bash/bashrc
nnoremap <leader>ebd <ESC>:e ~/dotfiles/bash/default.bashrc
nnoremap <leader>eba <ESC>:e ~/dotfiles/bash/after.bashrc
nnoremap <leader>ez  <ESC>:e ~/dotfiles/zsh/zshrc
nnoremap <leader>eza <ESC>:e ~/dotfiles/zsh/aliases.zsh
nnoremap <leader>ezf <ESC>:e ~/dotfiles/zsh/functions.zsh

" toggle gui menubar
nnoremap <leader>MM :set guioptions+=m<CR>
nnoremap <leader>mm :set guioptions-=m<CR>

" other options
"set nowrap                         " already set above
"set ignorecase                     " already set in .vimrc
"set laststatus=2                   " already set in .vimrc
"set encoding=utf-8                 " already set in .vimrc
"set backupdir=~/.vim/tmp/backup//  " already set in .vimrc
"set expandtab                      " already set in .vimrc
"set shiftwidth=4                   " already set in .vimrc
"set softtabstop=4                  " already set in .vimrc
"set wildmenu                       " already set in .vimrc
set wildmode=list:full
set wildignore+=*\\tmp\\*,*.swp,*.zip,*.exe,*\\target\\*,*.class,*.war,*.jar,*.ear
set fileformat=unix
" set foldcolumn=4
set nostartofline
set number
set modeline
set guioptions-=m  " turnoff the menu
set shell=/bin/bash
set mouse=a

" help with syntax highlighting errors
"let sh_minlines=200         " default = 200
"let sh_maxlines=400         " default = 2*minlines
"let c_minlines=100          " default = 50
"let java_minlines=100       " default = 10
"let g:vimsyn_minlines=      " @see |:syn-sync|
"let g:vimsyn_maxlines=      " @see |:syn-sync|

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

" change fold settings for groovy files
"if syntax == "groovy"
"  setlocal foldmethod=marker foldmarker={,}
"endif

" diff -w to ignore whitespace instead of -b
set diffopt+=iwhite
function DiffW()
  let opt = "-a --binary "
  if &diffopt =~ "icase"  | let opt = opt . "-i " | endif
  if &diffopt =~ "iwhite" | let opt = opt . "-w " | endif  " vim uses -b by default
  silent execute "!diff " . opt . v:fname_in . " " . v:fname_new . " > " . v:fname_out
endfunction
set diffexpr=DiffW()

" Append modeline after last line in buffer.
" Use substitute() instead of printf() to handle '%%s' modeline in LaTeX
" files.
function! AppendModeline()
  let l:modeline = printf(" vim: set ts=%d sw=%d tw=%d %set :",
        \ &tabstop, &shiftwidth, &textwidth, &expandtab ? '' : 'no')
  let l:modeline = substitute(&commentstring, "%s", l:modeline, "")
  call append(line("$"), l:modeline)
endfunction
nnoremap <silent> <leader>ml :call AppendModeline()<CR>

"
" }}}

" plugin-specific settings {{{
"

" NERDTree
" Check if NERDTree is open or active
function! IsNERDTreeOpen()
  return exists("t:NERDTreeBufName") && (bufwinnr(t:NERDTreeBufName) != -1)
endfunction

" Call NERDTreeFind iff NERDTree is active, current window contains a modifiable
" file, and we're not in vimdiff
function! SyncTree()
  if &modifiable && IsNERDTreeOpen() && strlen(expand('%')) > 0 && !&diff
    NERDTreeFind
    wincmd p
  endif
endfunction

" Highlight currently open buffer in NERDTree
" autocmd BufEnter * call SyncTree()
noremap <F1> :NERDTreeToggle<CR>
noremap <F2> :call SyncTree()<CR>

" MatchTagAlways
let g:mta_filetypes = { 'html' : 1, 'xhtml' : 1, 'xml' : 1, 'jinja' : 1, 'gsp' : 1 }

" Tagbar
let g:tagbar_left = 1

" use vim tabs like buffers
" @see https://stackoverflow.com/questions/102384/using-vims-tabs-like-buffers
"tab sball
"set switchbuf=usetab,newtab

" buftabs
"let g:buftabs_in_statusline = 1
"let g:buftabs_only_basename = 1
"let g:buftabs_active_hightlight_group="WildMenu"
"let g:buftabs_inactive_hightlight_group="StatusLine"
"noremap <C-tab>   :bnext<CR>
"noremap <C-S-tab> :bprev<CR>
"noremap <C-left>  :bprev<CR>
"noremap <C-right> :bnext<CR>

" svndiff
"let g:svndiff_autoupdate      = 1
"let g:svndiff_one_sign_delete = 1
"hi DiffAdd      ctermfg=0 ctermbg=2 guibg='green'
"hi DiffDelete   ctermfg=0 ctermbg=1 guibg='red'
"hi DiffChange   ctermfg=0 ctermbg=3 guibg='yellow'
"noremap <F3> :call Svndiff("prev")<CR>
"noremap <F4> :call Svndiff("next")<CR>
"noremap <F5> :call Svndiff("clear")<CR>

" MiniBuffExpl
"let g:miniBufExplMapWindowNavVim    = 1
"let g:miniBufExplMapWindowNavArrows = 1
"let g:miniBufExplMapCTabSwitchBufs  = 1
"let g:miniBufExplModSelTarget       = 1
"let g:miniBufExplUseSingleClick     = 1

" TabBar
"let g:Tb_MapCTabSwitchBufs = 1
"let g:Tb_UseSingleClick    = 1
"let g:Tb_ModSelTarget      = 1

"
" }}}

" font settings {{{
"

" Preview
"   ABCDEFGHIJKLMNOPQRSTUVWXYZ
"   abcdefghijklmnopqrstuvwxyz
"           0123456789
"      0Oo   I1l|   ,.   ;:
"   !@#$%^&*()_+-={}|[]\:"'<>?
"
" best
" set guifont=Source\ Code\ Pro\ for\ Powerline\ 11

" better
" set guifont=Input\ 10
" set guifont=Andale\ Mono\ 10

" good
" set guifont=Cousine\ 10
set guifont=Monospace\ 9
" set guifont=Liberation\ Mono\ 10
" set guifont=Ubuntu\ Mono\ 12

" so-so
" set guifont=Anonymous\ Pro\ 11
" set guifont=Inconsolata\ 12

" bad
" set guifont=Courier\ 10
" set guifont=Courier\ New\ 11
" set guifont=Droid\ Sans\ Mono\ 10

" }}}

" color and theme settings {{{
"

" themes: {{{
"   http://vimcolorschemetest.googlecode.com/svn/html/index-java.html
"
" + good dark themes with black backgrounds:
"   base16-grayscale, billw, blackboard, blacksea, candy, candycode,
"   charon, codeschool, corporation, darkbone, darkeclipse, desert256,
"   distinguished, dw_green, dw_orange, earendel, golden, greenvision,
"   jammy, jellybeans, koehler, metacosm, motus (torte), nour, railscasts,
"   rastafari, relaxedgreen, spiderhawk, stingray, synic, torte (motus),
"   twilight, vibrantink, vividchalk, vj, xterm16, zmrok
"
" + good dark themes without black backgrounds:
"   camo, ekvoli, freya (gui), gruvbox, jellyx, mint, mustang, native, obsidian,
"   railscasts, rdark, rdark-terminal, selenitic, solarized, tango2, watermark,
"   wombat, wombat256mod, xoria256
"
" + good light themes:
"   dawn, github, jhlight, kaltex, moria, nedit, osx_like, peaksea, smp, soso
"
" to test a theme, use hitest.vim
"   :so $VIMRUNTIME/syntax/hitest.vim
" }}}

function! InitMyTheme() " {{{
    if !has('gui_running')
        " terminal option to allow for 256 color; do not use with solarized
        set t_Co=256
    endif

    " -- favorite dark themes
    set background=dark

    color railscasts
    hi Special    term=bold      ctermfg=130 guifg=#af5f00
    hi Identifier term=underline ctermfg=130 guifg=#af5f00
    hi Type       term=underline ctermfg=130 guifg=#df5f00
    " hi CursorLine ctermbg=237
    " hi Normal ctermbg=234 guibg=#181818
    " hi Folded ctermfg=255 ctermbg=238
    " hi Comment gui=none

    " color xoria256

    " color base16-grayscale
    " color desertEx
    " color gruvbox
    " color jellyx
    " color obsidian
    " color selenitic

    " color mustang
    " hi Folded ctermbg=0  " use black backgound for folds

    " color candycode
    " hi Folded cterm=none gui=none  " turn off underlining

    " color desert256
    " modify CursorLine slightly; only works if cursorline is on
    " hi CursorLine cterm=NONE ctermbg=236 guibg=Grey20

    " color golden
    " turn terminal background to black instead of transparent
    " hi Normal ctermbg=black


    " -- favorite light themes
    " set background=light

    " color smp
    " color soso

    " -- transparent bg
    " use only use if terminal bg matches chosen colorscheme
    if !has('gui_running')
        hi Normal ctermbg=none
    endif
endfunction " }}}

function! InitMySolarized() " {{{
    " @see http://vimawesome.com/plugin/vim-colors-solarized-sparks-fly

    " let g:solarized_bold=0     " turn off bold
    " let g:solarized_italic=0   " turn off italic
    let g:solarized_underline=0  " turn off underline
    syntax enable
    set background=dark
    colorscheme solarized

    hi Comment gui=none
    if !has('gui_running')
        " override defaults:
        " let g:solarized_termcolors=256  " only use if term is not configured for solarized
        hi Normal ctermfg=8 ctermbg=NONE  " transparent bg, useful with solarized terminal colors
        hi Identifier         ctermfg=DarkCyan
        hi vimGroup           ctermfg=DarkCyan
        hi vimCmdSep          ctermfg=DarkCyan
        hi vimHiLink          ctermfg=DarkCyan
        hi vimHiGroup         ctermfg=DarkCyan
        hi htmlTagName        ctermfg=DarkCyan
        hi htmlSpecialTagName ctermfg=DarkCyan
        hi varId              ctermfg=DarkCyan
        hi Directory          ctermfg=DarkCyan
        hi MoreMsg            ctermfg=DarkCyan
        hi ModeMsg            ctermfg=DarkCyan
        hi DiffText           ctermfg=DarkCyan
        hi helpHyperTextJump  ctermfg=DarkCyan
        hi hs_hlFunctionName  ctermfg=DarkCyan
    endif " 'gui_running'
endfunction " }}}

" call InitMySolarized()
call InitMyTheme()

" }}}

"
" vim: set ft=vim fdm=marker:
