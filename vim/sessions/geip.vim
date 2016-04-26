" ~/dotfiles/vim/sessions/geip.vim:
" Vim session script.
" Created by session.vim 2.13.1 on 02 December 2015 at 15:15:44.
" Open this file in Vim and run :source % to restore your session.

set guioptions=aegit
silent! set guifont=Monospace\ 11
if exists('g:syntax_on') != 1 | syntax on | endif
if exists('g:did_load_filetypes') != 1 | filetype on | endif
if exists('g:did_load_ftplugin') != 1 | filetype plugin on | endif
if exists('g:did_indent_on') != 1 | filetype indent on | endif
if &background != 'dark'
	set background=dark
endif
if !exists('g:colors_name') || g:colors_name != 'railscasts' | colorscheme railscasts | endif
call setqflist([])
let SessionLoad = 1
if &cp | set nocp | endif
let s:so_save = &so | let s:siso_save = &siso | set so=0 siso=0
let v:this_session=expand("<sfile>:p")
silent only
cd ~/repos/work
if expand('%') == '' && !&modified && line('$') <= 1 && getline(1) == ''
  let s:wipebuf = bufnr('%')
endif
set shortmess=aoO
badd +22 geip/grails-app/conf/BuildConfig.groovy
badd +147 secc/grails-app/conf/Config.groovy
badd +63 secc/grails-app/conf/BuildConfig.groovy
badd +41 geip/grails-app/conf/Config.groovy
badd +69 secc/grails-app/conf/BootStrap.groovy
badd +1 geip/grails-app/conf/ApplicationResources.groovy
badd +4 geip/grails-app/conf/spring/resources.groovy
badd +1 secc/grails-app/conf/ApplicationResources.groovy
badd +2 secc/grails-app/conf/spring/resources.groovy
badd +67 geip/src/groovy/geip/DaoLdapAuthenticationProvider.groovy
badd +1 sharedleave/todo.txt.bak
badd +50 geip/grails-app/views/entry/processorList.gsp
badd +1 geip/grails-app/views/entry/managerList.gsp
badd +34 geip/grails-app/views/entry/_grid.js.gsp
badd +4 geip/grails-app/views/eipEntry/_eip_manager_grid.js.gsp
badd +14 geip/grails-app/views/letter/index.gsp
badd +356 geip/grails-app/views/letter/_eipPdf.gsp
badd +376 geip/grails-app/views/letter/_maPdf.gsp
badd +179 geip/grails-app/controllers/geip/LetterController.groovy
badd +1 geip/grails-app/views/home/_printEipTab.gsp
badd +28 geip/src/groovy/geip/AbstractLoader.groovy
badd +85 geip/grails-app/conf/DataSource.groovy
badd +51 geip/grails-app/services/geip/AdminService.groovy
badd +59 geip/grails-app/conf/BootStrap.groovy
badd +20 geip/src/groovy/geip/EipReader.groovy
badd +216 geip/grails-app/controllers/geip/HomeController.groovy
badd +16 geip/grails-app/services/geip/AbstractEntryService.groovy
badd +3 geip/grails-app/views/eipEntry/_eip_processor_grid.js.gsp
badd +5 geip/grails-app/controllers/geip/AbstractEntryController.groovy
badd +120 geip/grails-app/views/letter/OIP_Letter-UNCMC_Executive.gsp
badd +131 /srv/apps/oip/input/uncmc/OIP_Letter-UNCMC_Executive_Executive.html
badd +79 geip/grails-app/domain/geip/EipEntry.groovy
badd +49 geip/grails-app/views/home/_processorEipTab.gsp
badd +1 geip/grails-app/views/home/_managerMaTab.gsp
badd +137 geip/grails-app/controllers/geip/EipEntryController.groovy
badd +106 geip/web-app/css/errors.css
badd +179 geip/web-app/css/main.css
badd +101 geip/src/groovy/geip/AbstractEntry.groovy
badd +1 ~/dotfiles/vim/after.vimrc
badd +1 ~/dotfiles/vim/extra.vimrc
badd +189 ~/dotfiles/vim/vimrc
badd +1 ~/.gitconfig
badd +9 geip/grails-app/views/includes/_headerTemplate.gsp
badd +1 geip/grails-app/views/layouts/main.gsp
badd +58 geip/grails-app/services/geip/BootStrapService.groovy
badd +10 geip/src/groovy/geip/MaLoader.groovy
badd +28 geip/src/groovy/geip/MaReader.groovy
badd +62 geip/grails-app/domain/geip/MaEntry.groovy
badd +22 geip/grails-app/views/maEntry/_ma_processor_grid.js.gsp
badd +122 geip/grails-app/controllers/geip/MaEntryController.groovy
badd +3 geip/grails-app/views/maEntry/exportProcessorCsvView.gsp
badd +17 geip/grails-app/views/maEntry/_ma_manager_grid.js.gsp
badd +48 geip/grails-app/views/home/_processorMaTab.gsp
badd +104 geip/grails-app/views/home/manager.gsp
argglobal
silent! argdel *
edit geip/grails-app/views/letter/_maPdf.gsp
set splitbelow splitright
wincmd _ | wincmd |
vsplit
wincmd _ | wincmd |
vsplit
2wincmd h
wincmd w
wincmd w
set nosplitbelow
set nosplitright
wincmd t
set winheight=1 winwidth=1
exe 'vert 1resize ' . ((&columns * 31 + 127) / 255)
exe 'vert 2resize ' . ((&columns * 149 + 127) / 255)
exe 'vert 3resize ' . ((&columns * 73 + 127) / 255)
argglobal
enew
" file NERD_tree_1
setlocal fdm=manual
setlocal fde=0
setlocal fmr={{{,}}}
setlocal fdi=#
setlocal fdl=0
setlocal fml=1
setlocal fdn=20
setlocal nofen
wincmd w
argglobal
setlocal fdm=syntax
setlocal fde=0
setlocal fmr={{{,}}}
setlocal fdi=#
setlocal fdl=0
setlocal fml=1
setlocal fdn=20
setlocal fen
let s:l = 360 - ((42 * winheight(0) + 26) / 53)
if s:l < 1 | let s:l = 1 | endif
exe s:l
normal! zt
360
normal! 0
wincmd w
argglobal
edit geip/grails-app/controllers/geip/MaEntryController.groovy
setlocal fdm=syntax
setlocal fde=0
setlocal fmr={{{,}}}
setlocal fdi=#
setlocal fdl=0
setlocal fml=1
setlocal fdn=20
setlocal fen
let s:l = 89 - ((52 * winheight(0) + 26) / 53)
if s:l < 1 | let s:l = 1 | endif
exe s:l
normal! zt
89
normal! 062|
wincmd w
2wincmd w
exe 'vert 1resize ' . ((&columns * 31 + 127) / 255)
exe 'vert 2resize ' . ((&columns * 149 + 127) / 255)
exe 'vert 3resize ' . ((&columns * 73 + 127) / 255)
tabnext 1
if exists('s:wipebuf')
"   silent exe 'bwipe ' . s:wipebuf
endif
" unlet! s:wipebuf
set winheight=1 winwidth=83 shortmess=filnxtToO
let s:sx = expand("<sfile>:p:r")."x.vim"
if file_readable(s:sx)
  exe "source " . fnameescape(s:sx)
endif
let &so = s:so_save | let &siso = s:siso_save

" Support for special windows like quick-fix and plug-in windows.
" Everything down here is generated by vim-session (not supported
" by :mksession out of the box).

1wincmd w
tabnext 1
let s:bufnr_save = bufnr("%")
let s:cwd_save = getcwd()
NERDTree ~/repos/work
if !getbufvar(s:bufnr_save, '&modified')
  let s:wipebuflines = getbufline(s:bufnr_save, 1, '$')
  if len(s:wipebuflines) <= 1 && empty(get(s:wipebuflines, 0, ''))
    silent execute 'bwipeout' s:bufnr_save
  endif
endif
execute "cd" fnameescape(s:cwd_save)
1resize 53|vert 1resize 31|2resize 53|vert 2resize 149|3resize 53|vert 3resize 73|
2wincmd w
tabnext 1
if exists('s:wipebuf')
  if empty(bufname(s:wipebuf))
if !getbufvar(s:wipebuf, '&modified')
  let s:wipebuflines = getbufline(s:wipebuf, 1, '$')
  if len(s:wipebuflines) <= 1 && empty(get(s:wipebuflines, 0, ''))
    silent execute 'bwipeout' s:wipebuf
  endif
endif
  endif
endif
doautoall SessionLoadPost
unlet SessionLoad
" vim: ft=vim ro nowrap smc=128
