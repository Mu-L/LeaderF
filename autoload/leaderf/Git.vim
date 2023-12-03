" ============================================================================
" File:        Git.vim
" Description:
" Author:      Yggdroot <archofortune@gmail.com>
" Website:     https://github.com/Yggdroot
" Note:
" License:     Apache License, Version 2.0
" ============================================================================

if leaderf#versionCheck() == 0  " this check is necessary
    finish
endif

exec g:Lf_py "from leaderf.gitExpl import *"

function! leaderf#Git#Maps(id)
    nmapclear <buffer>
    exec g:Lf_py "import ctypes"
    let manager = printf("ctypes.cast(%d, ctypes.py_object).value", a:id)
    exec printf('nnoremap <buffer> <silent> <CR>          :exec g:Lf_py "%s.accept()"<CR>', manager)
    exec printf('nnoremap <buffer> <silent> o             :exec g:Lf_py "%s.accept()"<CR>', manager)
    exec printf('nnoremap <buffer> <silent> <2-LeftMouse> :exec g:Lf_py "%s.accept()"<CR>', manager)
    exec printf('nnoremap <buffer> <silent> x             :exec g:Lf_py "%s.accept(''h'')"<CR>', manager)
    exec printf('nnoremap <buffer> <silent> v             :exec g:Lf_py "%s.accept(''v'')"<CR>', manager)
    exec printf('nnoremap <buffer> <silent> t             :exec g:Lf_py "%s.accept(''t'')"<CR>', manager)
    exec printf('nnoremap <buffer> <silent> p             :exec g:Lf_py "%s._previewResult(True)"<CR>', manager)
    exec printf('nnoremap <buffer> <silent> j             :exec g:Lf_py "%s.moveAndPreview(''j'')"<CR>', manager)
    exec printf('nnoremap <buffer> <silent> k             :exec g:Lf_py "%s.moveAndPreview(''k'')"<CR>', manager)
    exec printf('nnoremap <buffer> <silent> <Up>          :exec g:Lf_py "%s.moveAndPreview(''Up'')"<CR>', manager)
    exec printf('nnoremap <buffer> <silent> <Down>        :exec g:Lf_py "%s.moveAndPreview(''Down'')"<CR>', manager)
    exec printf('nnoremap <buffer> <silent> <PageUp>      :exec g:Lf_py "%s.moveAndPreview(''PageUp'')"<CR>', manager)
    exec printf('nnoremap <buffer> <silent> <PageDown>    :exec g:Lf_py "%s.moveAndPreview(''PageDown'')"<CR>', manager)
    exec printf('nnoremap <buffer> <silent> q             :exec g:Lf_py "%s.quit()"<CR>', manager)
    exec printf('nnoremap <buffer> <silent> i             :exec g:Lf_py "%s.input()"<CR>', manager)
    exec printf('nnoremap <buffer> <silent> <Tab>         :exec g:Lf_py "%s.input()"<CR>', manager)
    exec printf('nnoremap <buffer> <silent> <F1>          :exec g:Lf_py "%s.toggleHelp()"<CR>', manager)
    exec printf('nnoremap <buffer> <silent> <C-Up>        :exec g:Lf_py "%s._toUpInPopup()"<CR>', manager)
    exec printf('nnoremap <buffer> <silent> <C-Down>      :exec g:Lf_py "%s._toDownInPopup()"<CR>', manager)
    exec printf('nnoremap <buffer> <silent> <Esc>         :exec g:Lf_py "%s.closePreviewPopupOrQuit()"<CR>', manager)
endfunction


function! leaderf#Git#TimerCallback(manager_id, id)
    exec g:Lf_py "import ctypes"
    exec g:Lf_py printf("ctypes.cast(%d, ctypes.py_object).value._callback(bang=True)", a:manager_id)
endfunction

function! leaderf#Git#WriteBuffer(view_id, id)
    exec g:Lf_py "import ctypes"
    exec g:Lf_py printf("ctypes.cast(%d, ctypes.py_object).value.writeBuffer()", a:view_id)
endfunction

function! leaderf#Git#Suicide(view_id)
    exec g:Lf_py "import ctypes"
    exec g:Lf_py printf("ctypes.cast(%d, ctypes.py_object).value.suicide()", a:view_id)
endfunction

function! leaderf#Git#Commands()
    if !exists(g:Lf_GitCommands)
        let g:Lf_GitCommands = {
                    \ "Leaderf git diff --directly":  "output the diffs directly",
                    \ "Leaderf git diff --cached --directly": "output `git diff --cached` directly",
                    \ "Leaderf git diff HEAD --directly":     "output `git diff HEAD` directly",
                    \ }
    else
    endif
endfunction
