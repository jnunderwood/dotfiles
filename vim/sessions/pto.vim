" ~/dotfiles/vim/sessions/pto.vim:
" Vim session script.
" Created by session.vim 2.13.1 on 05 April 2016 at 11:27:45.
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
call setqflist([{'lnum': 0, 'col': 0, 'valid': 1, 'vcol': 0, 'nr': -1, 'type': '', 'pattern': '', 'filename': 'fugitive:///home/junderwo/repos/work/pto22/.git//2e125cefe5cfad2316ffa3fe7a6d29e9c62c42d8/src/groovy/ptosb/GrossUp.groovy', 'text': 'replace magic number with Config variables; unit test to do so safely'}, {'lnum': 0, 'col': 0, 'valid': 1, 'vcol': 0, 'nr': -1, 'type': '', 'pattern': '', 'filename': 'fugitive:///home/junderwo/repos/work/pto22/.git//1725150848419559c69cb99f498cb3ecb10c3c3f/src/groovy/ptosb/GrossUp.groovy', 'text': 'var renames, refactoring'}, {'lnum': 0, 'col': 0, 'valid': 1, 'vcol': 0, 'nr': -1, 'type': '', 'pattern': '', 'filename': 'fugitive:///home/junderwo/repos/work/pto22/.git//84bfb6936904b864c3a9a4a09c1aad7bd46430f7/src/groovy/ptosb/GrossUp.groovy', 'text': 'rename test vars; replace method with Math.max(); remove commented code'}, {'lnum': 0, 'col': 0, 'valid': 1, 'vcol': 0, 'nr': -1, 'type': '', 'pattern': '', 'filename': 'fugitive:///home/junderwo/repos/work/pto22/.git//f0df41f60d71a84cdb762c7867408f981efa7690/src/groovy/ptosb/GrossUp.groovy', 'text': 'fill out rest of values for first test case'}, {'lnum': 0, 'col': 0, 'valid': 1, 'vcol': 0, 'nr': -1, 'type': '', 'pattern': '', 'filename': 'fugitive:///home/junderwo/repos/work/pto22/.git//c55ef979b974fc6b454b2fc7162efcb6d284623d/src/groovy/ptosb/GrossUp.groovy', 'text': 'Merge branch ''master'' into working branch'}, {'lnum': 0, 'col': 0, 'valid': 1, 'vcol': 0, 'nr': -1, 'type': '', 'pattern': '', 'filename': 'fugitive:///home/junderwo/repos/work/pto22/.git//0cdfe455e4e31a7463db39847f0021d1edffa444/src/groovy/ptosb/GrossUp.groovy', 'text': 'set up for new unit test'}, {'lnum': 0, 'col': 0, 'valid': 1, 'vcol': 0, 'nr': -1, 'type': '', 'pattern': '', 'filename': 'fugitive:///home/junderwo/repos/work/pto22/.git//f212d7021103c3d0705ebe390cf2efac8ca8e318/src/groovy/ptosb/GrossUp.groovy', 'text': 'Fixing previous bad merge. Updates include upgrade to Grails 2.2 and using new DaoLdapAuthenitcationProvider.'}, {'lnum': 0, 'col': 0, 'valid': 1, 'vcol': 0, 'nr': -1, 'type': '', 'pattern': '', 'filename': 'fugitive:///home/junderwo/repos/work/pto22/.git//c96fdcdf2b17b28de1f4fc8e2956637b74e11795/src/groovy/ptosb/GrossUp.groovy', 'text': 'initial move to using Config domain object'}, {'lnum': 0, 'col': 0, 'valid': 1, 'vcol': 0, 'nr': -1, 'type': '', 'pattern': '', 'filename': 'fugitive:///home/junderwo/repos/work/pto22/.git//bfedb662b162ef785af5f35a521505437fd60653/src/groovy/ptosb/GrossUp.groovy', 'text': 'changes to accomodate percentage-specific sell-back options'}])
let SessionLoad = 1
if &cp | set nocp | endif
let s:so_save = &so | let s:siso_save = &siso | set so=0 siso=0
let v:this_session=expand("<sfile>:p")
silent only
cd ~/repos/work/pto22
if expand('%') == '' && !&modified && line('$') <= 1 && getline(1) == ''
  let s:wipebuf = bufnr('%')
endif
set shortmess=aoO
badd +188 grails-app/conf/BootStrap.groovy
badd +7 grails-app/conf/spring/resources.groovy
badd +200 grails-app/conf/Config.groovy
badd +36 grails-app/conf/DataSource.groovy
badd +78 grails-app/controllers/LoginController.groovy
badd +45 grails-app/domain/ptosb/User.groovy
badd +95 grails-app/controllers/ptosb/UserController.groovy
badd +18 application.properties
badd +8 src/groovy/ptosb/GrossUp.groovy
argglobal
silent! argdel *
edit grails-app/conf/Config.groovy
set splitbelow splitright
wincmd _ | wincmd |
vsplit
wincmd _ | wincmd |
vsplit
2wincmd h
wincmd w
wincmd _ | wincmd |
split
1wincmd k
wincmd w
wincmd w
set nosplitbelow
set nosplitright
wincmd t
set winheight=1 winwidth=1
exe 'vert 1resize ' . ((&columns * 31 + 127) / 255)
exe '2resize ' . ((&lines * 22 + 24) / 48)
exe 'vert 2resize ' . ((&columns * 95 + 127) / 255)
exe '3resize ' . ((&lines * 23 + 24) / 48)
exe 'vert 3resize ' . ((&columns * 95 + 127) / 255)
exe 'vert 4resize ' . ((&columns * 127 + 127) / 255)
argglobal
enew
" file NERD_tree_2
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
let s:l = 200 - ((11 * winheight(0) + 11) / 22)
if s:l < 1 | let s:l = 1 | endif
exe s:l
normal! zt
200
normal! 018|
wincmd w
argglobal
edit grails-app/domain/ptosb/User.groovy
setlocal fdm=syntax
setlocal fde=0
setlocal fmr={{{,}}}
setlocal fdi=#
setlocal fdl=0
setlocal fml=1
setlocal fdn=20
setlocal fen
let s:l = 61 - ((15 * winheight(0) + 11) / 23)
if s:l < 1 | let s:l = 1 | endif
exe s:l
normal! zt
61
normal! 09|
wincmd w
argglobal
edit grails-app/conf/BootStrap.groovy
setlocal fdm=syntax
setlocal fde=0
setlocal fmr={{{,}}}
setlocal fdi=#
setlocal fdl=0
setlocal fml=1
setlocal fdn=20
setlocal fen
let s:l = 76 - ((45 * winheight(0) + 23) / 46)
if s:l < 1 | let s:l = 1 | endif
exe s:l
normal! zt
76
normal! 025|
wincmd w
4wincmd w
exe 'vert 1resize ' . ((&columns * 31 + 127) / 255)
exe '2resize ' . ((&lines * 22 + 24) / 48)
exe 'vert 2resize ' . ((&columns * 95 + 127) / 255)
exe '3resize ' . ((&lines * 23 + 24) / 48)
exe 'vert 3resize ' . ((&columns * 95 + 127) / 255)
exe 'vert 4resize ' . ((&columns * 127 + 127) / 255)
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
NERDTree ~/repos/work/pto22
if !getbufvar(s:bufnr_save, '&modified')
  let s:wipebuflines = getbufline(s:bufnr_save, 1, '$')
  if len(s:wipebuflines) <= 1 && empty(get(s:wipebuflines, 0, ''))
    silent execute 'bwipeout' s:bufnr_save
  endif
endif
execute "cd" fnameescape(s:cwd_save)
1resize 46|vert 1resize 31|2resize 22|vert 2resize 95|3resize 23|vert 3resize 95|4resize 46|vert 4resize 127|
4wincmd w
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
