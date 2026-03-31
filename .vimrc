" .vimrc : 2025/12/12

set encoding=utf-8
set fileencodings=utf-8,sjis,iso-2022-jp,euc-jp
set fileformats=unix,dos,mac

" 2016/01/07
set tabstop=4
set noswapfile
"set number
set undodir=~/.vim/undo
set paste

set nocompatible
set noautoindent
set nosmartindent
set mouse=a                      " マウス機能有効化
set cursorline                   " カーソルラインの強調表示を有効化
set display+=lastline            "画面最後の行をできる限り表示する。
set backspace=start,eol,indent   " [Backspace] で既存の文字を削除できるように設定
set whichwrap=b,s,[,],,~         " 特定のキーに行頭および行末の回りこみ移動を許可する設定
set incsearch                    " インクリメンタル検索を有効化
set wildmenu wildmode=list:full  " 補完時の一覧表示機能有効化

" 2015/12/08
" バックアップ(~ファイル）を作成しない
set nobackup

"ステータス行を表示
set laststatus=2
"ステータス行の指定
set statusline=%<%f\ %m%r%h%w
"set statusline+=%{'['.(&fenc!=''?&fenc:&enc).']['.&fileformat.']'}
set statusline=%F%m%r%h%w\ [FORMAT=%{&ff}]\ [ENC=%{&fileencoding}]\ [TYPE=%Y]\ [POS=%04l,%04v][%p%%]
set statusline+=%=%l/%L,%c%V%8P

" 2025/12/12
" エラーメッセージを赤から「明るい水色背景 + 黒文字」に変更
" これにより、濃紺背景の中でも文字が非常に読みやすくなります
highlight ErrorMsg   cterm=bold ctermfg=Black ctermbg=Cyan gui=bold guifg=Black guibg=#00ffff
highlight Error      cterm=bold ctermfg=Black ctermbg=Cyan gui=bold guifg=Black guibg=#00ffff

" 警告メッセージも合わせて「明るい緑」などにすると区別しやすくなります
highlight WarningMsg cterm=bold ctermfg=Black ctermbg=Green gui=bold guifg=Black guibg=#00ff00


" デフォルト不可視文字は美しくないのでUnicodeで綺麗に
set listchars=tab:»-,trail:-,extends:»,precedes:«,nbsp:%,eol:↲

" w!! でスーパーユーザーとして保存（sudoが使える環境限定）
cmap w!! w !sudo tee > /dev/null %
                                                                                  
"カーソル移動時は、画面の右端を改行の扱いにする
:nnoremap j gj
:nnoremap k gk

"インサートモードでも移動
inoremap <c-d> <delete>
inoremap <c-j> <down>
inoremap <c-k> <up>
inoremap <c-h> <left>
inoremap <c-l> <right>

" Ctrl + hjkl でウィンドウ間を移動
nnoremap <C-h> <C-w>h
nnoremap <C-j> <C-w>j
nnoremap <C-k> <C-w>k
nnoremap <C-l> <C-w>l

" Remember the cursor locaiton when closing a file
if has("autocmd")
    autocmd BufReadPost *
    \ if line("'\"") > 0 && line ("'\"") <= line("$") |
    \   exe "normal! g'\"" |
    \ endif
endif


" 日本語関連
"if has('multi_byte_ime') || has('xim')
if has('multi_byte_ime') || has('xim') || has('fcitx')
    " 日本語入力ON時のカーソルの色を設定
    highlight CursorIM guibg=Purple guifg=NONE
endif

"日本語の行の連結時には空白を入力しない。
set formatoptions+=mM

"□や○の文字があってもカーソル位置がずれないようにする。
set ambiwidth=double

" 全角スペースのハイライトを設定
function! ZenkakuSpace()
  highlight ZenkakuSpace cterm=underline ctermfg=darkgrey gui=underline guifg=darkgrey
endfunction


" markdown 
" md as markdown, instead of modula2
"autocmd MyAutoGroup BufNewFile,BufRead *.{md,mdwn,mkd,mkdn,mark*} set filetype=markdown
" Disable highlight italic in Markdown
"autocmd MyAutoGroup FileType markdown hi! def link markdownItalic LineNr
let g:vim_markdown_folding_disabled=1

" golang
filetype off
filetype plugin indent off
set runtimepath+=$GOROOT/misc/vim
"filetype plugin indent on
syntax on
autocmd FileType go autocmd BufWritePre <buffer> Fmt
exe "set rtp+=".globpath($GOPATH, "src/github.com/nsf/gocode/vim")
set completeopt=menu,preview

" python
autocmd FileType python setl autoindent
autocmd FileType python setl smartindent cinwords=if,elif,else,for,while,try,except,finally,def,class
autocmd FileType python setl tabstop=4 expandtab shiftwidth=4 softtabstop=4

" changelog 
autocmd FileType go autocmd BufWritePre <buffer> Fmt
"let g:changelog_timeformat = "%Y-%m-%d"
let g:changelog_dateformat= "%Y-%m-%d"
let g:changelog_username = ""



" OSごとの設定 =====================================
if has('unix') 
" *nix 用設定 --------------------------------------

endif

if has('mac')
" Mac 用設定 ---------------------------------------
" fixing vimproc_mac.so error on Mac OSX 
if has('mac')
   let g:vimproc_dll_path = $VIMRUNTIME . '/autoload/proc.so'
   let g:vimproc_dll_path = $VIMRUNTIME . '/autoload/vimproc_mac.so'
endif
" 2020/05/13
"set clipboard+=unnamed
" 2025/05/17
set clipboard+=unnamed
" Map Ctrl+C for copying text (vmap <D-c> "+y didn't work)
vmap <C-c> "+y
endif
 
if has('unix') || has('mac')
" Unix と Mac の共通設定 ---------------------------

endif  

if has('win32unix') 
" Cygwin 用設定 ------------------------------------
" 2015/05/14  enable copy & paste on babun+vim
set mouse=""
set clipboard+=unnamed
set clipboard+=autoselect

endif  " end cygwin 用設定
 

" --- Windows PowerShell 用 ---
if has('win32') || has('win64')
    " 文字の可読性を優先した設定で上書き
    highlight CursorLine cterm=NONE ctermfg=White ctermbg=233 guifg=#ffffff guibg=#1c1c1c
    highlight CursorLineNr cterm=bold ctermfg=183 gui=bold guifg=#d7afff
    set clipboard+=unnamed
endif
 

" バージョンごとの設定：7.3以上で対応
if v:version >= 703
  "set relativenumber

else
  "set number

endif


"" 「日本語入力固定モード」の動作モード
"let IM_CtrlMode = 2
"" 「日本語入力固定モード」切替キー
"inoremap <silent> <C-j> <C-^><C-r>=IMState('FixMode')<CR>
"
"" IM制御がToggleしか行えない時「日本語入力固定モード」を切り替えると Toggleも実行する
"let IM_JpFixModeAutoToggle = 1
"
"" <ESC>押下後のIM切替開始までの反応が遅い場合はttimeoutlenを短く設定してみてください(ミリ秒)
"set timeout timeoutlen=3000 ttimeoutlen=100

function! IMCtrl(cmd)
  let cmd = a:cmd
  if cmd == 'On'
    silent !echo -n -e "\0033[1v"
    redraw!
  elseif cmd == 'Off'
    silent !echo -n -e "\0033[0v"
    redraw!
  elseif cmd == 'Toggle'
    silent !echo -n -e "\0033[2v"
    redraw!
  endif
  return ''
endfunction



" -----------------------------------------------------------------------------------
"カラースキーマを設定
"colorscheme desert

"" colours 
""highlight Comment ctermfg=Green 
"highlight Comment ctermfg=Yellow
"highlight Constant ctermfg=Red 
"highlight Identifier ctermfg=Cyan 
""highlight Identifier ctermfg=Yellow
""highlight Statement ctermfg=Yellow 
"highlight Statement ctermfg=Magenta
"highlight Title ctermfg=Magenta 
"highlight Special ctermfg=Magenta 
"highlight PreProc ctermfg=Magenta 


" ステータスラインの色
"highlight statusline   term=NONE cterm=NONE guifg=white ctermfg=black ctermbg=yellow
"highlight StatusLine guifg=blue  guibg=yellow gui=none ctermfg=white ctermbg=green cterm=none
highlight statusline guifg=white guibg=yellow gui=none ctermfg=black ctermbg=green term=NONE cterm=NONE 
"highlight StatusLine guifg=darkblue guibg=darkyellow gui=none ctermfg=blue ctermbg=yellow cterm=none

" 行番号の色
":highlight LineNr ctermfg=239
highlight LineNr ctermfg=4


" モードによってカーソルの形を変える
let &t_ti.="\e[1 q"
let &t_SI.="\e[5 q"
let &t_EI.="\e[1 q"
let &t_te.="\e[0 q"

