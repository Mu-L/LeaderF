#!/usr/bin/env python
# -*- coding: utf-8 -*-

import vim
import re
import os
import os.path
from leaderf.utils import *
from leaderf.explorer import *
from leaderf.manager import *


#*****************************************************
# BufferExplorer
#*****************************************************
class BufferExplorer(Explorer):
    @showRelativePath
    def getContent(self, *args, **kwargs):
        show_unlisted = False if len(args) == 0 else args[0]
        if show_unlisted:
            return [b.name for b in vim.buffers if b.name is not None]
        if int(vim.eval("v:version")) > 703:
            return [b.name for b in vim.buffers if b.options["buflisted"]]
        else:
            return [b.name for b in vim.buffers if vim.eval("buflisted('%s')"
                    % escQuote(b.name)) == '1']

    def acceptSelection(self, *args, **kwargs):
        if len(args) == 0:
            return
        file = args[0]
        vim.command("hide edit %s" % escSpecial(file))

    def getStlFunction(self):
        return 'Buffer'

    def getStlCurDir(self):
        return escQuote(lfEncoding(os.getcwd()))

    def supportsNameOnly(self):
        return True


#*****************************************************
# BufExplManager
#*****************************************************
class BufExplManager(Manager):
    def _getExplClass(self):
        return BufferExplorer

    def _defineMaps(self):
        vim.command("call g:LfBufExplMaps()")

    def _createHelp(self):
        help = []
        help.append('" <CR>/<double-click>/o : open file under cursor')
        help.append('" x : open file under cursor in a horizontally split window')
        help.append('" v : open file under cursor in a vertically split window')
        help.append('" t : open file under cursor in a new tabpage')
        help.append('" d : wipe out buffer under cursor')
        help.append('" D : delete buffer under cursor')
        help.append('" i : switch to input mode')
        help.append('" s : select multiple files')
        help.append('" a : select all files')
        help.append('" c : clear all selections')
        help.append('" q : quit')
        help.append('" <F1> : toggle this help')
        help.append('" ---------------------------------------------------------')
        return help

    def deleteBuffer(self, wipe=0):
        if vim.current.window.cursor[0] <= self._help_length:
            return
        vim.command("setlocal modifiable")
        try:
            line = vim.current.line
            if wipe == 0:
                vim.command("confirm bd %s" % re.sub(' ', '\\ ',
                            os.path.abspath(line)))
            else:
                vim.command("confirm bw %s" % re.sub(' ', '\\ ',
                            os.path.abspath(line)))
            if len(self._content) > 0:
                self._content.remove(line)
            del vim.current.line
        except:
            pass
        vim.command("setlocal nomodifiable")



#*****************************************************
# bufExplManager is a singleton
#*****************************************************
bufExplManager = BufExplManager()

__all__ = ['bufExplManager']