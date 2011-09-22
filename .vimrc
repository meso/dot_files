" 基本設定
set nocompatible                "Vi互換なし
set expandtab                   "タブを空白に展開
set backspace=indent,eol,start  "バックスペースでインデントや改行を削除
set whichwrap=b,s,h,l,<,>,[,]   "カーソルを行頭行末で止まらないように
set formatoptions=lmoq          "テキスト整形オプションにマルチバイト系追加
set wrapscan                    "検索時に最後まで行ったら最初に戻る
set showmatch                   "対応する括弧表示
set vb t_vb=                    "ビープ音OFF
set showmode                    "現在のモード表示
set showcmd                     "コマンド表示
set number                      "行番号表示
set ruler                       "ルーラー表示
set list                        "タブや改行を表示
set wrap                        "長い行を折り返して表示
set laststatus=2                "常にステータス行を表示
set title                       "タイトルを表示
set ignorecase                  "検索で大文字小文字を無視
set smartcase                   "検索で大文字小文字が含まれてたら無視しない
set formatoptions+=mM           "テキスト挿入の自動折り返しの日本語対応
set cmdheight=1                 "コマンドラインの高さ
set hidden                      "編集中でも他のファイルを開ける
autocmd BufReadPost * if line("'\"") > 0 && line("'\"") <= line("$") | exe "normal g`\"" | endif

" 
syntax enable

filetype off
" for pathogen
"call pathogen#runtime_append_all_bundles()
" for vundle
set rtp+=~/.vim/vundle.git/
call vundle#rc()
"Github Repos
Bundle 'pangloss/vim-javascript'
Bundle 'Shougo/neocomplcache'
Bundle 'Shougo/unite.vim'
Bundle 'kchmck/vim-coffee-script'
Bundle 'Shougo/vimproc'
Bundle 'Shougo/vimshell'
Bundle 'thinca/vim-quickrun'
Bundle 'digitaltoad/vim-jade'
Bundle 'wavded/vim-stylus'

" ファイルタイプ判定ON
filetype plugin indent on

" インデント
set autoindent              "自動的にインデント
set smartindent             "新しい行のインデントを今の形と同じに
set shiftwidth=2            " 
set tabstop=2               "タブ幅
filetype indent on

"OSのクリップボードを使う
set clipboard+=unnamed

"マウス使う
set mouse=a
set guioptions+=a
set ttymouse=xterm2

"不可視文字の表示形式
set listchars=tab:>.,trail:_,extends:>,precedes:<

" 全角スペースの表示
highlight ZenkakuSpace cterm=underline ctermfg=lightblue guibg=darkgray
match ZenkakuSpace /　/

" カーソル行をハイライト
set cursorline
" カレントウィンドウにのみ罫線を引く
augroup cch
  autocmd! cch
  autocmd WinLeave * set nocursorline
  autocmd WinEnter,BufRead * set cursorline
augroup END

"hi clear CursorLine
:hi CursorLine gui=underline
highlight CursorLine ctermbg=black guibg=black

" F2で前のバッファ
map <F2> <ESC>:bp<CR>
" F3で次のバッファ
map <F3> <ESC>:bn<CR>
" F4でバッファを削除
map <F4> <ESC>:bw<CR>

" インサートモードでhjkl移動
imap <C-j> <Down>
imap <C-k> <Up>
imap <C-l> <Right>
imap <C-h> <Left>

" 改行文字
set fileformats=unix,dos,mac
" デフォルトエンコード
set encoding=utf-8

" 文字コード関連
if !has('kaoriya')
" from ずんWiki http://www.kawaz.jp/pukiwiki/?vim#content_1_7
" 文字コードの自動認識
  if &encoding !=# 'utf-8'
    set encoding=japan
    set fileencoding=japan
  endif
  if has('iconv')
    let s:enc_euc = 'euc-jp'
    let s:enc_jis = 'iso-2022-jp'
    " iconvがeucJP-msに対応しているかをチェック
    if iconv("\x87\x64\x87\x6a", 'cp932', 'eucjp-ms') ==# "\xad\xc5\xad\xcb"
      let s:enc_euc = 'eucjp-ms'
      let s:enc_jis = 'iso-2022-jp-3'
    " iconvがJISX0213に対応しているかをチェック
    elseif iconv("\x87\x64\x87\x6a", 'cp932', 'euc-jisx0213') ==# "\xad\xc5\xad\xcb"
      let s:enc_euc = 'euc-jisx0213'
      let s:enc_jis = 'iso-2022-jp-3'
    endif
    " fileencodingsを構築
    if &encoding ==# 'utf-8'
      let s:fileencodings_default = &fileencodings
      let &fileencodings = s:enc_jis .','. s:enc_euc .',cp932'
      let &fileencodings = &fileencodings .','. s:fileencodings_default
      unlet s:fileencodings_default
    else
      let &fileencodings = &fileencodings .','. s:enc_jis
      set fileencodings+=utf-8,ucs-2le,ucs-2
      if &encoding =~# '^\(euc-jp\|euc-jisx0213\|eucjp-ms\)$'
        set fileencodings+=cp932
        set fileencodings-=euc-jp
        set fileencodings-=euc-jisx0213
        set fileencodings-=eucjp-ms
        let &encoding = s:enc_euc
        let &fileencoding = s:enc_euc
      else
        let &fileencodings = &fileencodings .','. s:enc_euc
      endif
    endif
    " 定数を処分
    unlet s:enc_euc
    unlet s:enc_jis
  endif
  " 日本語を含まない場合は fileencoding に encoding を使うようにする
  if has('autocmd')
    function! AU_ReCheck_FENC()
      if &fileencoding =~# 'iso-2022-jp' && search("[^\x01-\x7e]", 'n') == 0
        let &fileencoding = &encoding
      endif
    endfunction
    autocmd BufReadPost * call AU_ReCheck_FENC()
  endif
endif

" □とか○の文字があってもカーソル位置がずれないようにする
if exists('&ambiwidth')
  set ambiwidth=double
endif

" insertモードを抜けるとIMEオフ
set noimdisable
set iminsert=0 imsearch=0
set noimcmdline
inoremap <silent> <ESC> <ESC>:set iminsert=0<CR>

"ステータスラインに文字コードと改行文字を表示する
if winwidth(0) >= 120
  set statusline=%<[%n]%m%r%h%w%{'['.(&fenc!=''?&fenc:&enc).':'.&ff.']'}%y\ %F%=[%{GetB()}]\ %l,%c%V%8P
else
  set statusline=%<[%n]%m%r%h%w%{'['.(&fenc!=''?&fenc:&enc).':'.&ff.']'}%y\ %f%=[%{GetB()}]\ %l,%c%V%8P
endif

"入力モード時、ステータスラインのカラーを変更
augroup InsertHook
autocmd!
autocmd InsertEnter * highlight StatusLine guifg=#ccdc90 guibg=#2E4340
autocmd InsertLeave * highlight StatusLine guifg=#2E4340 guibg=#ccdc90
augroup END

function! GetB()
  let c = matchstr(getline('.'), '.', col('.') - 1)
  let c = iconv(c, &enc, &fenc)
  return String2Hex(c)
endfunction
" help eval-examples
" The function Nr2Hex() returns the Hex string of a number.
func! Nr2Hex(nr)
  let n = a:nr
  let r = ""
  while n
    let r = '0123456789ABCDEF'[n % 16] . r
    let n = n / 16
  endwhile
  return r
endfunc
" The function String2Hex() converts each character in a string to a two
" character Hex string.
func! String2Hex(str)
  let out = ''
  let ix = 0
  while ix < strlen(a:str)
    let out = out . Nr2Hex(char2nr(a:str[ix]))
    let ix = ix + 1
  endwhile
  return out
endfunc

