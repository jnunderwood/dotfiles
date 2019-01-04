" my theme settings

syntax enable

" allow themes to use bold and italic fonts
let g:enable_bold_font = 1
let g:enable_italic_font = 1

" true colors - must use a terminal which supports true colors
if has("termguicolors")
  " set Vim-specific sequences for RGB colors
  " @see https://github.com/vim/vim/issues/993
  let &t_8f = "\<Esc>[38;2;%lu;%lu;%lum"
  let &t_8b = "\<Esc>[48;2;%lu;%lu;%lum"
  set termguicolors
else
  set t_AB="\<Esc>[48;5;%dm"
  set t_AF="\<Esc>[38;5;%dm"
  set t_Co=256
endif

" visualize whitespace; @see also "general.vimrc listchars"
" fake highlight only leading spaces
hi WhiteSpaceBol ctermfg=238 guifg=#444444
hi WhiteSpaceMol ctermfg=235 ctermbg=235 guifg=#2b2b2b guibg=#2b2b2b
match WhiteSpaceMol / /
2match WhiteSpaceBol /^ \+/

" my favorite colorscheme
colorscheme darcula

" for vim color names and mappings, see colors.vimrc

" override some colors
hi LineNr ctermfg=60 ctermbg=234 guifg=#5f5f87 guibg=#1c1c1c
hi CursorLine ctermbg=234 guibg=#1c1c1c
hi NonText ctermfg=238 guifg=#444444 guibg=#2b2b2b

" override some font styles
hi Boolean cterm=bold
hi Character cterm=italic
hi Comment cterm=italic gui=italic
hi Conditional cterm=bold
hi Constant cterm=bold
hi Define cterm=bold
hi DiffAdd cterm=bold
hi DiffText cterm=bold
hi Function cterm=bold
hi Keyword cterm=bold
hi PreProc cterm=bold
hi Special cterm=bold
hi StorageClass cterm=bold
hi Todo cterm=bold,italic
hi Type cterm=bold
hi jsFunction cterm=bold
hi javaScriptFunction cterm=bold
hi markdownHeadingDelimiter cterm=bold

" make background transparent
"hi Normal ctermbg=NONE
"hi EndOfBuffer ctermbg=NONE

" vim-sneak settings
hi SneakPluginTarget ctermfg=black ctermbg=234 guibg=#181818

" performance improvement settings
" @see http://stackoverflow.com/questions/4775605/vim-syntax-highlight-improve-performance
" @see http://vim.wikia.com/wiki/Fix_syntax_highlighting
"syntax sync minlines=256
"set cursorcolumn
"set nocursorline

