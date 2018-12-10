set encoding=utf-8
scriptencoding utf-8
language C

"----------------------------------------------------------
" alias
"----------------------------------------------------------
"cnoreabbrev <Alias name> <Alias command>
cnoreabbrev indent shiftwidth=

"----------------------------------------------------------
" operation
"----------------------------------------------------------
set wildmenu wildmode=list:longest,full " コマンドラインモードでTABキーによるファイル名補完を有効にする
set history=1000                        " コマンドラインの履歴をXXXX件保存する
set clipboard=unnamed,unnamedplus       " クリップボードをOSと共有
set scrolloff=8                         " 上下8行の視界を確保
set sidescrolloff=16                    " 左右スクロール時の視界を確保
set sidescroll=1                        " 左右スクロールは一文字づつ行う
set whichwrap+=h,l,<,>,[,],b,s          " 行末・行頭から次の行へ移動可能に
set backspace=indent,eol,start          " Backspaceキーの影響範囲に制限を設けない
set nostartofline                       " ページアップ・ダウン時にカーソル位置を移動しない
set hidden                              " 変更中のファイルでの、保存しないで他のファイルを表示する
set autoread                            " 編集中のファイルが変更されたら自動で読み直す
set noswapfile                          " ファイル編集中にスワップファイルを作らない
set confirm                             " 保存されていないファイルがあるときは終了前に保存確認
set formatoptions=q                     " 改行無効化
" インサートモードにてjjでエスケープ
inoremap jj <Esc>
" 行が折り返し表示されていた場合、行単位ではなく表示行単位でカーソルを移動する
nnoremap j gj
nnoremap k gk
nnoremap <down> gj
nnoremap <up> gk
noremap <Up> <Nop>
noremap <Down> <Nop>
noremap <Left> <Nop>
noremap <Right> <Nop>
nnoremap <F1> <nop>
imap <C-l> <Right>
"----------------------------------------------------------
" visual
"----------------------------------------------------------
set number                                                " 行番号表示
set showmatch                                             " 括弧入力時の対応する括弧を表示
set list                                                  " 不可視文字の表示
set listchars=tab:»･,trail:-,extends:»,precedes:«,nbsp:%  " 不可視文字の表示形式指定
set ambiwidth=double                                      " □や○文字が崩れる問題を解決

"----------------------------------------------------------
" tab function
"----------------------------------------------------------
set smarttab
set expandtab     " タブ入力を複数の空白入力に置き換える
set tabstop=2     " 画面上でタブ文字が占める幅
set softtabstop=2 " 連続した空白に対してタブキーやバックスペースキーでカーソルが動く幅
set autoindent    " 改行時に前の行のインデントを継続する
set smartindent   " 改行時に前の行の構文をチェックし次の行のインデントを増減する
set shiftwidth=2  " smartindentで増減する幅
" pythonファイルを編集する際はshiftwidthを4にする
augroup fileTypeIndent
    autocmd!
    autocmd BufNewFile,BufRead *.py setlocal tabstop=4 softtabstop=4 shiftwidth=4
augroup END

"----------------------------------------------------------
"" search function
"----------------------------------------------------------
set incsearch  " インクリメンタルサーチ. １文字入力毎に検索を行う
set ignorecase " 検索パターンに大文字小文字を区別しない
set smartcase  " 検索パターンに大文字を含んでいたら大文字小文字を区別する
set hlsearch   " 検索結果をハイライト
set wrapscan   " 最後まで検索したら頭に戻る
" ESCキー2度押しでハイライトの切り替え
nnoremap <silent><Esc><Esc> :<C-u>set nohlsearch!<CR>

"----------------------------------------------------------
"" others
"----------------------------------------------------------
set vb t_vb=     " ビープ音を消す
set noerrorbells " エラーメッセージの表示時にビープを鳴らさない
set matchtime=3  " 対応カッコの表示秒数を3秒に

" クリップボードからのペーストの場合、自動インデントを無効
if &term =~ "xterm"
    let &t_SI .= "\e[?2004h"
    let &t_EI .= "\e[?2004l"
    let &pastetoggle = "\e[201~"

    function XTermPasteBegin(ret)
        set paste
        return a:ret
    endfunction

    inoremap <special> <expr> <Esc>[200~ XTermPasteBegin("")
endif

"==========================================================
" NEO BUNDLE
"==========================================================
""" Note: Skip initialization for vim-tiny or vim-small.
if 0 | endif

if &compatible
  set nocompatible               " Be iMproved
endif

" Required:
set runtimepath+=~/.vim/bundle/neobundle.vim/

" Required:
call neobundle#begin(expand('~/.vim/bundle/'))

" Let NeoBundle manage NeoBundle
" Required:
NeoBundleFetch 'Shougo/neobundle.vim'

"----------------------------------------------------------
" インストール
"----------------------------------------------------------
" NeoBundle 'altercation/vim-colors-solarized' " color-theme-solarized
NeoBundle 'bronson/vim-trailing-whitespace'  " 末尾の全角と半角の空白文字を赤くハイライト
NeoBundle 'itchyny/lightline.vim'            " ステータスラインの表示内容強化
NeoBundle 'Yggdroot/indentLine'              " インデントの可視化
NeoBundle 'Shougo/unite.vim'                 " Unite検索
NeoBundle 'Shougo/neomru.vim'                " for Unite
NeoBundle "slim-template/vim-slim"           " sytax for slim
NeoBundle "tyru/caw.vim.git"                 " multiple comment out via ctrl + k
if has('lua')
  NeoBundle 'Shougo/neocomplete.vim'       " コード自動補完
  NeoBundle "Shougo/neosnippet"            " スニペットの補完機能
  NeoBundle 'Shougo/neosnippet-snippets'   " スニペット集
endif
"----------------------------------------------------------
" setting colorscheme
"----------------------------------------------------------
syntax enable
set synmaxcol=100
" set background=dark
colorscheme solarized
let g:solarized_termcolors=256

"----------------------------------------------------------
" multiple comment out via ctrl + k
"----------------------------------------------------------
map <C-K> <Plug>(caw:hatpos:toggle)
vmap <C-K> <Plug>(caw:hatpos:toggle)

"----------------------------------------------------------
" ステータスラインの設定
"----------------------------------------------------------
set laststatus=2 " ステータスラインを常に表示
let g:lightline = {
        \ 'colorscheme': 'solarized',
        \ 'mode_map': {'c': 'NORMAL'},
        \ }

"----------------------------------------------------------
" neocomplete・neosnippetの設定
"----------------------------------------------------------
if neobundle#is_installed('neocomplete.vim')
    " Vim起動時にneocompleteを有効にする
    let g:neocomplete#enable_at_startup = 1
    " smartcase有効化. 大文字が入力されるまで大文字小文字の区別を無視する
    let g:neocomplete#enable_smart_case = 1
    " 3文字以上の単語に対して補完を有効にする
    let g:neocomplete#min_keyword_length = 2
    " 区切り文字まで補完する
    let g:neocomplete#enable_auto_delimiter = 1
    " 1文字目の入力から補完のポップアップを表示
    let g:neocomplete#auto_completion_start_length = 1
    " バックスペースで補完のポップアップを閉じる
    inoremap <expr><BS> neocomplete#smart_close_popup()."\<C-h>"

    " エンターキーで補完候補の確定. スニペットの展開もエンターキーで確定・・・・・・②
    imap <expr><CR> neosnippet#expandable() ? "\<Plug>(neosnippet_expand_or_jump)" : pumvisible() ? "\<C-y>" : "\<CR>"
    " タブキーで補完候補の選択. スニペット内のジャンプもタブキーでジャンプ・・・・・・③
    imap <expr><TAB> pumvisible() ? "<C-n>" : neosnippet#jumpable() ? "\<Plug>(neosnippet_expand_or_jump)" : "\<TAB>"
else
    inoremap <expr><CR>  pumvisible() ? neocomplcache#close_popup() : "\<CR>"
endif

" define file path where set original snippet files
let g:neosnippet#snippets_directory = '~/dotfiles/snippets/'

" call appropriate snip file via extension
augroup filetypedetect
  autocmd!  BufEnter *_spec.rb NeoSnippetSource ~/dotfiles/snippets/rspec.snip
  autocmd!  BufEnter *rb call s:LoadRailsSnippet()
augroup END

" rails用スニペット呼び出し関数
function! s:LoadRailsSnippet()

  " fetch current dir path
  let s:current_file_path = expand("%:p:h")

  "ignore unless in app dir
  if ( s:current_file_path !~ "app/" )
    return

  " if in model dir
  elseif ( s:current_file_path =~ "app/models" )
    NeoSnippetSource ~/dotfiles/snippets/model.rails.snip

  " if in controller dir
  elseif ( s:current_file_path =~ "app/controllers" )
   NeoSnippetSource ~/dotfiles/snippets/controller.rails.snip

  " if in view dir
  elseif ( s:current_file_path =~ "app/views" )
    NeoSnippetSource ~/dotfiles/snippets/view.rails.snip

  " app/helpersフォルダ内ならば
  "elseif ( s:current_file_path =~ app/helpers" )
  "  NeoSnippetSource ~/dotfiles/snippets/helper.rails.snip

  " app/assetsフォルダ内ならば
  "elseif ( s:current_file_path =~ app/assets")
  "  NeoSnippetSource ~/dotfiles/snippets/asset.rails.snip
  endif
endfunction

"----------------------------------------------------------
" unite setting
"----------------------------------------------------------
let g:unite_source_history_yank_enable =1
  "prefix keyの設定
  nmap <Space> [unite]

  "スペースキーとaキーでカレントディレクトリを表示
  nnoremap <silent> [unite]a :<C-u>UniteWithBufferDir -buffer-name=files file<CR>

  "スペースキーとスペースキーでバッファと最近開いたファイル一覧を表示
  nnoremap <silent> [unite]<Space> :<C-u>Unite<Space>buffer file_mru<CR>

  "スペースキーとdキーで最近開いたディレクトリを表示
  nnoremap <silent> [unite]d :<C-u>Unite<Space>directory_mru<CR>

  "スペースキーとbキーでバッファを表示
  nnoremap <silent> [unite]b :<C-u>Unite<Space>buffer<CR>

  ""スペースキーとrキーでレジストリを表示
  nnoremap <silent> [unite]r :<C-u>Unite<Space>register<CR>

  "スペースキーとtキーでタブを表示
  nnoremap <silent> [unite]t :<C-u>Unite<Space>tab<CR>

  "スペースキーとhキーでヒストリ/ヤンクを表示
  " nnoremap <silent> [unite]h :<C-u>Unite<Space>history/yank<CR>

  "スペースキーとoキーでoutline
  " nnoremap <silent> [unite]o :<C-u>Unite<Space>outline<CR>

  "スペースキーとENTERキーでfile_rec:!
  " nnoremap <silent> [unite]<CR> :<C-u>Unite<Space>file_rec:!<CR>

  "unite.vimを開いている間のキーマッピング
  autocmd FileType unite call s:unite_my_settings()


  " ESCでuniteを終了
  function! s:unite_my_settings()"{{{
        nmap <buffer> <ESC> <Plug>(unite_exit)
  endfunction"}}}

call neobundle#end()

" Required:
filetype plugin indent on

" If there are uninstalled bundles found on startup,
" this will conveniently prompt you to install them.
NeoBundleCheck
