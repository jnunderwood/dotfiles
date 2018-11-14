syntax on
syntax enable
set t_Co=256

" true color support - must use a terminal which supports true colors, e.g., termite
"if (has("termguicolors"))
"  set termguicolors
"endif

let g:enable_bold_font = 1
let g:enable_italic_font = 1

colorscheme darcula

"hi Normal ctermbg=235
" make background transparent
hi Normal ctermbg=NONE
hi EndOfBuffer ctermbg=NONE

hi LineNr ctermbg=234
hi CursorLine ctermbg=234

" vim-sneak settings
hi SneakPluginTarget ctermfg=black ctermbg=181818

