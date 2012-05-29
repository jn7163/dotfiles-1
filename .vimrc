" When started as "evim", evim.vim will already have done these settings.
if v:progname =~? "evim"
finish
endif

" 当终端支持颜色或者运行着gui版本时打开高亮及搜索关键词高亮
if &t_Co > 2 || has("gui_running")
    syntax on
    set hlsearch
endif

" 设置搜索方向为向前搜索
set incsearch

if has("autocmd")
    filetype plugin indent on
    augroup vimrcEx
    au!
    autocmd FileType text setlocdth=78
    " 编辑文件时，自动回到上次位置
    autocmd BufReadPost *
                \ if line("'\"") > 1 && line("'\"") <= line("$") |
                \   exe "normal! g`\"" |
                \ endif
augroup END
else
    set autoindent
endif

" 自动缩进
set autoindent

" 打开不同类型文件特有的缩近
filetype plugin indent on

" 文件编码
" set fencs=utf-8,gbk
" Win32 简体中文
"set encoding=cp936
" Win32 简体中文
"set encoding=cp936
" UNIX 简体中文
set encoding=utf-8
set fileencodings=ucs-bom,utf-8,gb18030
set fileencoding=utf-8
set termencoding=utf-8

" 去掉utf-8 bom
" set nobomb
" 保留utf-8 bom
" set bomb

"颜色主题
if $TERM =~ '^\(xterm\|screen\)' || $TERM =~ '256color$' || has("gui_running")
    if !has("gui_running")
        set t_Co=256
    endif
    colorscheme slate
else
    colorscheme tango
endif

" 高亮当前行
"autocmd InsertLeave * set nocursorline
"autocmd InsertEnter * set cursorline

" Use Vim settings, rather then Vi settings (much better!).
" This must be first, because it changes other options as a side effect.
set nocompatible

" allow backspacing over everything in insert mode
"set backspace=indent,eol,start

" 设置 Backspace 和 Delete 的灵活程度，backspace=2 则没有任何限制
set backspace=2

" 设置命令历史行数为50行
set history=50

" 设置当前光标位置
set ruler

" 在命令末尾输完之前显示命令
set showcmd

" Make command line two lines high
set ch=1

" 显示TAB健
set list
set listchars=tab:>-,trail:-

" 设置路径，在 f 等命令中涉及此参数
" 对于 windows 编程，path 可设为如下
" set path=.,"C:\Program Files\Microsoft Visual Studio\vc98\Include",,
" 对于 UNIX 编程，path 可设为如下
"set path=.,/usr/include,/usr/include/qt,,

" 告诉 Vim 先尝试用 UNIX 格式在尝试 MS-DOS 格式

set fileformats=unix,dos ff=unix

" 搜索忽略大小写
set ignorecase smartcase

" 显示行号
set nu!

" 制表符TAB宽度，保持兼容
set tabstop=4

" 每层缩进空格数
set softtabstop=4

" 指定下一级的缩近空格数
set cindent shiftwidth=4

" 将输入的TAB自动展开成空格
set et

" 在C注释中高亮字符串
"let c_comment_strings=1

" 关闭备份
set nobackup

" 设置备份目录
"set backupdir=~/Tmp

" 如果当前目录找不到tags文件，则向上一级目录查找
set tags=./tags,./../tags,./*/tags,~/tags

"map :runtime syntax/2html.vim

" 定义剪切命令
"unmap
"map "+x
"imap "+xi

" 定义复制命令
"unmap
"map "+y
"imap "+yi

" 定义粘贴命令
"unmap
"map "+gp
"imap "+gpi

" 定义撤销命令
"unmap
"map u
"imap ui

" 编辑模式下 Ctrl+o 插入新行
"unmap
"imap o

" Ctrl+a 全选
"map ggVG
"imap ggVGi

" Ctrl+s 保存文件
"unmap
"map :w
"imap :wi
"cmap :w

" 用于浏览tags的脚本
"map ,t :Tlist
"map ,te :TagExplorer

" 用于浏览project的脚本
"map ,P :Project ./.vimprojects

" 设定 TagExplorer 环境
"let TE_Include_File_Pattern = '[Mm]akefile\(\..*\)\?\|.*\.c\(pp\)\?$\|.*\.h$\|.

" 进入当前编辑的文件的目录
" autocmd BufEnter * exec "cd %:p:h"

" 带有如下符号的单词不要被换行分割
set iskeyword+=_,$,@,%,#,-

" 高亮字符，让其不受100列限制
:highlight OverLength ctermbg=red ctermfg=white guibg=red guifg=white
":match OverLength '\%101v.*'

" 状态行颜色
highlight StatusLine guifg=SlateBlue guibg=Yellow
highlight StatusLineNC guifg=Gray guibg=White

" 字符间插入的像素行数目
set linespace=0

" 增强模式中的命令行自动完成操作
set wildmenu

" 命令行（在状态行下）的高度，默认为1
set cmdheight=1

" 允许backspace和光标键跨越行边界
set whichwrap+=<,>,h,l

" 不让vim发出讨厌的滴滴声
set noerrorbells
set vb t_vb=

" 在被分割的窗口间显示空白，便于阅读
set fillchars=vert:\ ,stl:\ ,stlnc:\

" 我的状态行显示的内容（包括文件类型和解码）
if has("statusline")
 set statusline=%F%m%r%h%w\ %=[FORMAT=%{&ff}]\ %{\"[\".(&fenc==\"\"?&enc:&fenc).((exists(\"+bomb\")\ &&\ &bomb)?\",B\":\"\").\"]\"}\ [TYPE=%Y]\ [POS=%l,%v][%p%%]\ %{strftime(\"%d/%m/%y\ -\ %H:%M\")}
" set statusline=%F%m%r%h%w\ [FORMAT=%{&ff}]\ %=%{\"[\".(&fenc==\"\"?&enc:&fenc).((exists(\"+bomb\")\ &&\ &bomb)?\",B\":\"\").\"]\ \"}%k\ %-14.(%l,%c%V%)\ %P\ %{strftime(\"%d/%m/%y\ -\ %H:%M\")}
" set statusline=%<%f\ %h%m%r%=%{\"[\".(&fenc==\"\"?&enc:&fenc).((exists(\"+bomb\")\ &&\ &bomb)?\",B\":\"\").\"]\ \"}%k\ %-14.(%l,%c%V%)\ %P
endif

" 总是显示状态行
set laststatus=2

" 去掉windows系统文件中的^M
se ff=unix

" 限制mutt文本宽度在72个字符
au BufRead /tmp/mutt-* set tw=72


"常用快捷键定义
"map <C-a> ggVG
"map <C-c> y
"map <C-v> p
"map <C-u> u
"map <C-s> :w

let g:WC_min_len=2
:autocmd BufEnter * call DoWordComplete() 
autocmd FileType javascript set omnifunc=javascriptcomplete#CompleteJS
autocmd FileType html set omnifunc=htmlcomplete#CompleteTags
autocmd FileType css set omnifunc=csscomplete#CompleteCSS
autocmd FileType xml set omnifunc=xmlcomplete#CompleteTags
autocmd FileType php set omnifunc=phpcomplete#CompletePHP

autocmd FileType php setlocal makeprg=zca\ %<.php
autocmd FileType php setlocal errorformat=%f(line\ %l):\ %m

autocmd BufNewFile,BufRead *.sh set ft=sh
autocmd BufNewFile,BufRead *.lua set ft=lua
autocmd BufNewFile,BufRead *.py set ft=py

let Tlist_Use_Right_Window=1
let Tlist_File_Fold_Auto_Close=1
let Tlist_Ctags_Cmd='/usr/bin/ctags'
let Tlist_Process_File_Always=1
map <C-X><C-t> :TlistToggle<cr>
map <C-X><C-x> :WMToggle<cr>
map ca :Calendar<cr>
"map ^X^S :w<cr>
"map ^X^X ^[:quite!<cr>

"let s:vimimdata = '/home/havanna/.vim/plugin/pinyin/'

" vimwiki
" 关闭驼峰英文成为维基词条
let g:vimwiki_camel_case = 0
" 标记为完成的 checklist 项目会有特别的颜色
let g:vimwiki_hl_cb_checked = 1
" 是否开启按语法折叠(会让文件比较慢)
let g:vimwiki_folding = 1
" 是否在计算字串长度时考虑中文字符
let g:vimwiki_CJK_length = 1
" 标签
let g:vimwiki_valid_html_tags = 'b,i,s,u,sub,sup,kbd,del,br,hr,div,code,h1,h2,h3,h4,h5,h6,p'

let g:vimwiki_use_mouse = 1
let g:vimwiki_list = [{'path':'~/Backup/wiki/', 'path_html': '~/Documents/html/', 'html_header': '~/.vim/autoload/vimwiki/header.tpl', 'html_footer': '~/.vim/autoload/vimwiki/footer.tpl', 'auto_export': 1,}]

let g:vimrc_author='Havanna'
let g:vimrc_email='havanna.sha#gmail.com'
let g:vimrc_homepage='http://ihavanna.org'
nmap <F4> :AuthorInfoDetect<cr>

" GNU Compile with gcc
set makeprg=gcc\ -Wall\ -o\ %<\ %
"Save and make current file.o
function! Make()
    let curr_dir = expand('%:h')
    if curr_dir == ''
        let curr_dir = '.'
    endif
    echo curr_dir
    execute 'lcd ' . curr_dir
    execute 'make'
    execute 'lcd -'
endfunction
nmap <F7> :update<CR>:call Make()<CR>
