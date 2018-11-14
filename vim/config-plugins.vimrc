filetype plugin indent on

" neomake config
autocmd! BufWritePost * Neomake
" autocmd BufLeave * QFix
let g:neomake_place_signs = 0
let g:neomake_open_list = 2
let g:neomake_javascript_enabled_makers = ['eslint']

" CtrlP
let g:ctrlp_prompt_mappings={'PrtClearCache()':['<Leader><F5>']}
let g:ctrlp_prompt_mappings={'PrtdeleteEnt()':['<Leader><F7>']}
let g:ctrlp_match_window='bottom,order:btt,min:2,max:25'
set wildmenu " enhanced autocomplete
set wildmode=list:full
set wildignore+=*/tmp/*,*.so,*.swp,*.zip,*node_modules*,*.jpg,*.png,*.svg,*.ttf,*.woff,*.woff3,*.eot,*.class,*.war,*.jar,*.ear
",*public/css/*,*public/js*

" delimitMate options
let delimitMate_expand_cr = 1

" javascript libraries syntax
let g:used_javascript_libs = 'jquery,underscore,react,flux,chai,mustache,vue'

" completion
augroup omnifuncs
  autocmd!
  autocmd FileType css setlocal omnifunc=csscomplete#CompleteCSS
  autocmd FileType html,markdown setlocal omnifunc=htmlcomplete#CompleteTags
  autocmd FileType python setlocal omnifunc=pythoncomplete#Complete
  autocmd FileType xml setlocal omnifunc=xmlcomplete#CompleteTags
  autocmd FileType php setlocal omnifunc=phpcomplete#CompletePHP
augroup end

" tern
if exists('g:plugs["tern_for_vim"]')
  let g:deoplete#omni#functions = {}
  let g:deoplete#omni#functions.javascript = [
    \ 'tern#Complete',
    \ 'jspc#omni'
  \]
endif

" deoplete
let g:deoplete#enable_at_startup = 1
let g:deoplete#sources = {}
let g:deoplete#sources['javascript.jsx'] = ['file', 'ultisnips', 'ternjs']
let g:tern#command = ['tern']
let g:tern#arguments = ['--persistent']
let g:tern_request_timeout = 1
let g:SuperTabClosePreviewOnPopupClose = 1

" disable colorizer at startup
let g:colorizer_startup = 0
let g:colorizer_nomap = 1

" emmet-vim settings
" let g:user_emmet_settings = { "html": { "quote_char": "'"} }

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

" vim-indent-object
let g:indentobject_meaningful_indentation = ["haml", "sass", "python", "yaml", "markdown"]

" vim-indent-line
"set list lcs=tab:\|\
let g:indentLine_color_term = 111
let g:indentLine_color_gui = '#DADADA'
let g:indentLine_char = 'c'
"let g:indentLine_char = '∙▹¦'
let g:indentLine_char = '∙'

let g:syntastic_enable_signs = 1
let g:syntastic_auto_loc_list = 1
let g:syntastic_mode_map = { 'mode': 'active', 'active_filetypes': ['ruby', 'python', ], 'passive_filetypes': ['html', 'css', 'slim'] }

" vim-markdown
let g:markdown_fenced_languages = ['coffee', 'css', 'erb=ruby', 'javascript', 'js=javascript', 'json=javascript', 'java', 'groovy', 'ruby', 'sass', 'xml', 'html', 'shell']
let g:vim_markdown_conceal = 0

" markdown-compatible table mode
let g:table_mode_corner = '|'

" sessions
let g:session_directory = '~/tmp/nvim/sessions'
let g:session_autosave = 'no'
let g:session_autoload = 'no'

" syntastic
let g:syntastic_enable_signs = 1
let g:syntastic_auto_loc_list = 1
let g:syntastic_mode_map = { 'mode': 'active', 'active_filetypes': ['ruby', 'python', ], 'passive_filetypes': ['html', 'css', 'slim'] }
