call plug#begin('~/.config/nvim/plugged')

" colorschemes
Plug 'blueshirts/darcula'
"Plug 'isobit/vim-darcula-colors'
Plug 'tomasiser/vim-code-dark'

" general
Plug 'tpope/vim-sensible'
Plug 'ervandew/supertab'
Plug 'benekastah/neomake'
Plug 'scrooloose/nerdtree', { 'on':  'NERDTreeToggle' }
Plug 'SirVer/ultisnips'
Plug 'honza/vim-snippets'
Plug 'haya14busa/incsearch.vim'
Plug 'kien/ctrlp.vim'
Plug 'vim-utils/vim-husk'
"Plug 'tpope/vim-obsession'
Plug 'xolox/vim-misc'
Plug 'xolox/vim-session'
Plug 'wincent/terminus'
if has('nvim')
  Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }
endif

" editing
Plug 'junegunn/vim-easy-align'
Plug 'mbbill/undotree'
"Plug 'tpope/vim-commentary'
Plug 'tomtom/tcomment_vim'
Plug 'airblade/vim-gitgutter'
Plug 'nathanaelkane/vim-indent-guides' " `,ig` to toggle
"Plug 'Raimondi/delimitMate'  " causes errors: <SNR>50_TriggerAbb()
Plug 'tpope/vim-repeat'
Plug 'tpope/vim-speeddating'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-unimpaired'
Plug 'justinmk/vim-sneak'
Plug 'vim-scripts/camelcasemotion'

" programming languages in general
Plug 'w0rp/ale' " asynchronous linting/fixing for Vim and Language Server Protocol (LSP) integration
Plug 'AndrewRadev/splitjoin.vim'

" java
Plug 'neoclide/coc.nvim', {'branch': 'release'}

" javascript
Plug 'guileen/vim-node-dict'
Plug '1995eaton/vim-better-javascript-completion'
Plug 'gavocanov/vim-js-indent'
Plug 'digitaltoad/vim-jade'
Plug 'mxw/vim-jsx'
Plug 'posva/vim-vue'
Plug 'ternjs/tern_for_vim', { 'for': ['javascript', 'javascript.jsx'] }
if has('nvim')
  Plug 'carlitux/deoplete-ternjs', { 'for': ['javascript', 'javascript.jsx'] }
endif
Plug 'pangloss/vim-javascript', { 'for': ['javascript', 'json']  }
Plug 'elzr/vim-json', { 'for': ['javascript', 'json']  }
Plug 'moll/vim-node', { 'for': ['javascript', 'json']  }
Plug 'isRuslan/vim-es6', { 'for': ['javascript', 'json']  }
Plug 'othree/javascript-libraries-syntax.vim', { 'for': ['javascript']  }
Plug 'othree/jspc.vim', { 'for': ['javascript', 'json']  }
Plug 'othree/es.next.syntax.vim', { 'for': ['javascript', 'json']  }
Plug 'othree/javascript-syntax.vim', { 'for': ['javascript', 'json']  }
Plug 'othree/jsdoc-syntax.vim', { 'for': ['javascript', 'json']  }
Plug 'othree/yajs.vim'

" CSS / HTML
"Plug 'ap/vim-css-color', { 'for': ['css', 'html']  }
Plug 'hail2u/vim-css3-syntax', { 'for': ['css', 'scss','sass']  }
Plug 'Glench/Vim-Jinja2-Syntax', { 'for': ['html']  }
Plug 'cakebaker/scss-syntax.vim', { 'for': ['scss', 'sass']  }
Plug 'groenewege/vim-less', { 'for': ['less']  }
Plug 'mattn/emmet-vim'
Plug 'ciaranm/detectindent'
Plug 'othree/html5.vim'
Plug 'hail2u/vim-css3-syntax'
Plug 'othree/csscomplete.vim'
Plug 'terryma/vim-multiple-cursors'
Plug 'sukima/xmledit'

" markdown and tables
Plug 'dhruvasagar/vim-table-mode'
"Plug 'godlygeek/tabular'
Plug 'plasticboy/vim-markdown'
" Plug 'tpope/vim-markdown'

" docker
Plug 'ekalinin/Dockerfile.vim', { 'for': ['docker', 'Dockerfile']  }

" text objects
Plug 'wellle/targets.vim'
Plug 'kana/vim-textobj-user'
Plug 'glts/vim-textobj-comment'
Plug 'kana/vim-textobj-fold'
Plug 'kana/vim-textobj-indent'
Plug 'kana/vim-textobj-function'
Plug 'thinca/vim-textobj-function-javascript'

" tmux integration
Plug 'edkolev/tmuxline.vim'
Plug 'wellle/tmux-complete.vim'
Plug 'tmux-plugins/vim-tmux'
Plug 'tmux-plugins/vim-tmux-focus-events'
Plug 'christoomey/vim-tmux-navigator'
Plug 'roxma/vim-tmux-clipboard'

" zsh
Plug 'chrisbra/vim-zsh', { 'for': ['zsh'] }
Plug 'rkitover/vimpager'

" logs
Plug 'thinca/vim-logcat', { 'for': ['logcat'] }
Plug 'dzeban/vim-log-syntax', { 'for': ['log'] }
Plug 'chr4/nginx.vim', { 'for': ['nginx'] }

" miscellaneous
Plug 'vim-scripts/grails-vim'
"Plug 'tpope/vim-fugitive'
Plug 'gregsexton/gitv'
Plug 'scrooloose/syntastic'
Plug 'troydm/easybuffer.vim'
Plug 'Xuyuanp/nerdtree-git-plugin'
Plug 'scrooloose/nerdcommenter'
Plug 'Valloric/MatchTagAlways'
Plug 'majutsushi/tagbar'
Plug 'jiangmiao/auto-pairs'
Plug 'editorconfig/editorconfig-vim'
"Plug 'tpope/vim-endwise' " causes problems when using pumvisible
Plug 'tpope/vim-eunuch'
Plug 'michaeljsmith/vim-indent-object'
Plug 'Yggdroot/indentLine'
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'junegunn/fzf.vim'
Plug 'Mizuchi/vim-ranger'

" eye candy
"Plug 'myusuf3/numbers.vim'
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'lilydjwg/colorizer', { 'on': 'ColorToggle' }
Plug 'wavded/vim-stylus'
Plug 'cohlin/vim-colorschemes'
Plug 'guns/xterm-color-table.vim'
Plug 'psliwka/vim-smoothie'
" call devicons last
Plug 'ryanoasis/vim-devicons'

call plug#end()
