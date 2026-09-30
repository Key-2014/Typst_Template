# 今後の開発案
## init.ps1への機能追加
もし実行時のPCでtypstがない場合には，wingetからインストールさせる．

## github releaseを利用した，install_typst-template.exe(仮)でのテンプレートインストール
githubのReleaseから.exeファイルをダウンロードし，ダブルクリックで実行するだけで，このリポジトリ内のテンプレートをパスを指定して置く．

パスは，C:\Users\%USERNAME%\typst\templates\Typst_Template\(仮)に置かれるようにする．

この変更に合わせ，スニペットによるインポート部分を絶対パスにすれば，どこからでもテンプレートを使用可能．

.exeファイル実行時には，init.ps1も同時に実行（typst本体のwingetインストールなど）

## submoduleと，.exeによるインストールの2通りに区別
### submodule
今までと同様

### .exeによるインストール
init.ps1による実行では，指定したフォルダへの.vscode,.github等の各種ファイルが置かれない．

よって，init.ps1とは別の方法でtypst本体のインストールなどを行う

#### .exeの仕様
- テンプレートインストール場所を指定（デフォルトはC:\Users\%USERNAME%\typst\templates\Typst_Template）
- wingetを利用したtypst本体のインストール（必要に応じて）
- .vscode,.github等の，vscodeやgithubでの管理専用ファイルはインストールさせない．（必要な場合はsubmoduleによる実装）
- Harano Ajiフォントのダウンロード及びインストールも，.exe実行時にできればなお良い
- インストール先を指定するUIを導入（ボタンでフォルダ選択など）（仮）
この仕様変更に応じたsubmoduleの仕様変更も必要かもしれない．

submodule時には完全に必要なファイルのみを持ってくるようにする．（.vscodeや.githubなど）

submodule時にテンプレートファイル等も持ってくるかどうかは要検討

## README.mdの内容を修正
submodule及び.exeについての説明を追加