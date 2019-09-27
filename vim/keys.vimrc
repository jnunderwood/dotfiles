" map Leader
let mapleader = ","

" keep backward f search, remapping it to ,;
nnoremap <Leader>; ,

" in-line scrolling
nmap <Leader>j gj
nmap <Leader>k gk

" buffer keys
nmap <leader>be :EasyBufferToggle<cr>
nnoremap <Leader>bb :b#<CR>
nnoremap <Leader>bn :bn<CR>
nnoremap <Leader>bp :bp<CR>
nnoremap <Leader>bf :bf<CR>
nnoremap <Leader>bl :bl<CR>
nnoremap <Leader>bw :w<CR>:bd<CR>
nnoremap <Leader>bd :bd!<CR>
" new buffer/tab
nnoremap <Leader>e :enew<CR>

" window keys
nnoremap <Leader>w< <C-w><
nnoremap <Leader>w> <C-w>>
nnoremap <Leader>w- <C-w>-
nnoremap <Leader>w+ <C-w>+
nnoremap <Leader>ws :split<CR>
nnoremap <Leader>wv :vsplit<CR>
nnoremap <Leader>wx :close<CR>

" %% to expand active buffer location on cmdline
cnoremap <expr> %% getcmdtype() == ':' ? expand('%:h').'/' : '%%'

" CtrlP keys
nnoremap <Leader>pp :CtrlP<CR>
nnoremap <Leader>pf :CtrlP<CR>
nnoremap <Leader>pm :CtrlPMRUFiles<CR>
nnoremap <Leader>pr :CtrlPMRUFiles<CR>
nnoremap <Leader>pb :CtrlPBuffer<CR>

" Function keys
nnoremap <silent> <F2> :let _s=@/<Bar>:%s/\s\+$//e<Bar>:let @/=_s<Bar>:nohl<CR>
nnoremap <F3> :set hlsearch!<CR>
nnoremap <F4> :set notermguicolors<CR>
nnoremap <F5> :source $HOME/.config/nvim/init.vim<CR>
nnoremap <F6> :NERDTreeToggle<CR>
nnoremap <F7> :UndotreeToggle<CR>
nnoremap <F8> :Geeknote<CR>
" indent whole file according to syntax rules
noremap <F9> gg=G

" CTRL-U in insert mode deletes a lot.  Use CTRL-G u to first break undo,
" so that you can undo CTRL-U after inserting a line break.
inoremap <C-U> <C-G>u<C-U>
" Don't use Ex mode, use Q for formatting
map Q gq

" relative line numbers
" nnoremap <Leader>3 :NumbersToggle<CR>

" remap number increment to C-s (C-a is already in use by tmux)
nmap <C-s> <C-a>

" Word count selection
vnoremap <Leader>w :w !wc -w<CR>

" vim paste mode toggle (for fixing indentation issues when pasting text)
nnoremap <F2> :set invpaste paste?<CR>
set pastetoggle=<F2>
set showmode

" override read-only permissions
cmap w!! %!sudo tee > /dev/null %

" allow ,, for vimsneak
nmap <Leader>, <Plug>SneakPrevious

" camelCase motion settings
map <silent> w <Plug>CamelCaseMotion_w
map <silent> b <Plug>CamelCaseMotion_b
map <silent> e <Plug>CamelCaseMotion_e
sunmap w
sunmap b
sunmap e

" start interactive EasyAlign in visual mode (e.g. vip<Enter>)
vmap <Enter> <Plug>(EasyAlign)

" start interactive EasyAlign for a motion/text object (e.g. gaip)
nmap ga <Plug>(EasyAlign)

" neomake
nmap <Leader><Space>o :lopen<CR>
nmap <Leader><Space>c :lclose<CR>
nmap <Leader><Space>, :ll<CR>
nmap <Leader><Space>n :lnext<CR>
nmap <Leader><Space>p :lprev<CR>

" folding
nmap <Leader>f zf%

" tern
autocmd FileType javascript nnoremap <silent> <buffer> gb :TernDef<CR>

" autocomplete
let g:SuperTabDefaultCompletionType="<c-x><c-o>"
let g:UltiSnipsExpandTrigger="<C-j>"
inoremap <expr><TAB>  pumvisible() ? "\<C-n>" : "\<TAB>"

" colorizer
nmap <Leader>tc :ColorToggle<CR>

" Source current line
vnoremap <leader>L y:execute @@<cr>
" Source visual selection
nnoremap <leader>L ^vg_y:execute @@<cr>

" Yank from current cursor position to end of line
map Y y$
" Yank content in OS's clipboard. `o` stands for "OS's Clipoard".
vnoremap <leader>yo "*y
" Paste content from OS's clipboard
nnoremap <leader>po "*p

" clear highlight after search
noremap <silent><Leader>/ :nohls<CR>

" better ESC
"inoremap <C-k> <Esc>

" Emacs bindings in command line mode
cnoremap <c-a> <home>
cnoremap <c-e> <end>

" clear search matching
noremap <leader><space> :noh<cr>:call clearmatches()<cr>

" Don't jump when using * for search
nnoremap * *<c-o>

" Keep search matches in the middle of the window.
nnoremap n nzzzv
nnoremap N Nzzzv

" Same when jumping around
nnoremap g; g;zz
nnoremap g, g,zz

" Open a Quickfix window for the last search.
nnoremap <silent> <leader>? :execute 'vimgrep /'.@/.'/g %'<CR>:copen<CR>

" Highlight word
nnoremap <silent> <leader>hh :execute 'match InterestingWord1 /\<<c-r><c-w>\>/'<cr>
nnoremap <silent> <leader>h1 :execute 'match InterestingWord1 /\<<c-r><c-w>\>/'<cr>
nnoremap <silent> <leader>h2 :execute '2match InterestingWord2 /\<<c-r><c-w>\>/'<cr>
nnoremap <silent> <leader>h3 :execute '3match InterestingWord3 /\<<c-r><c-w>\>/'<cr>

" more natural movement with wrap on
nnoremap j gj
nnoremap k gk
vnoremap j gj
vnoremap k gk

" Easy splitted window navigation
noremap <C-h>  <C-w>h
noremap <C-j>  <C-w>j
noremap <C-k>  <C-w>k
noremap <C-l>  <C-w>l

" Easy buffer navigation
noremap <leader>bp :bprevious<cr>
noremap <leader>bn :bnext<cr>

" Splits ,v and ,h to open new splits (vertical and horizontal)
nnoremap <leader>sv <C-w>v<C-w>l
nnoremap <leader>sh <C-w>s<C-w>j

" Reselect visual block after indent/outdent
vnoremap < <gv
vnoremap > >gv

" Bubbling lines
nmap <C-Up> [e
nmap <C-Down> ]e
vmap <C-Up> [egv
vmap <C-Down> ]egv

" nmap <tab> :NERDTreeToggle<cr>

" Space to toggle folds.
nnoremap <space> za
vnoremap <space> za

" Make zO recursively open whatever top level fold we're in, no matter where the
" cursor happens to be.
nnoremap zO zCzO

" Use ,z to "focus" the current fold.
nnoremap <leader>z zMzvzz

" Highlight currently open buffer in NERDTree
" autocmd BufEnter * call SyncTree()
noremap <F1> :NERDTreeToggle<CR>
noremap <F2> :call SyncTree()<CR>

" tab wrapper
inoremap <tab> <c-r>=InsertTabWrapper()<cr>
" Shift+Tab decreases indentation (insert mode)
inoremap <S-Tab> <Esc><<i

" tagbar
nmap <leader>t :TagbarToggle<cr>

" nerdcommenter
nmap <leader># :call NERDComment(0, "invert")<cr>
vmap <leader># :call NERDComment(0, "invert")<cr>

" fugitive
"nmap <leader>gs :Gstatus<CR>
"nmap <leader>gc :Gcommit -v<CR>
"nmap <leader>gac :Gcommit --amen -v<CR>

" grep
nmap <leader>g :Ggrep
" ,f for global git search for word under the cursor (with highlight)
nmap <leader>f :let @/="\\<<C-R><C-W>\\>"<CR>:set hls<CR>:silent Ggrep -w "<C-R><C-W>"<CR>:ccl<CR>:cw<CR><CR>
" same in visual mode
:vmap <leader>f y:let @/=escape(@", '\\[]$^*.')<CR>:set hls<CR>:silent Ggrep -F "<C-R>=escape(@", '\\"#')<CR>"<CR>:ccl<CR>:cw<CR><CR>

" file preview with fzf, rg, bat, and devicons
nnoremap <silent> <leader>e :call Fzf_dev()<CR>

" fix colors
nnoremap <leader>c :set notermguicolors<CR>
