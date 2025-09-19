"Turns on syntax coloration
syntax on
"Turn off funky auto-indenting
set paste
"Setup editor for PEP 8 Compliance
"  see: https://www.python.org/dev/peps/pep-0008
set expandtab    "inserts spaces in place of tabs.
set shiftwidth=4 "for >> operation.
set tabstop=4 "
set softtabstop=4
set autoindent
"sets up auto indenting based on filetype plugin.
filetype plugin indent on

"turn on status in vim
set laststatus=2
set statusline+=%-3.3n\                         " buffer number
set statusline=%t                               "tail of the filename
set statusline+=[%{strlen(&fenc)?&fenc:'none'}, "file encoding
set statusline+=%{&ff}]                         "file format
set statusline+=%h                              "help file flag
set statusline+=%m                              "modified flag
set statusline+=%r                              "read only flag
set statusline+=%y                              "filetype
set statusline+=%=                              "left/right separator
set statusline+=%c,                             "cursor column
set statusline+=%l/%L                           "cursor line/total lines
set statusline+=\ %P                            "percent through file
set statusline+=%=                               "right align
set statusline+=%{synIDattr(synID(line('.'),col('.'),1),'name')}\  " highlight

"I don't use swap files due to large file manipulation. Version control ftw.
set nobackup
set noswapfile
