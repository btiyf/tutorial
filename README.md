# tutorial
IT基礎研修用のチュートリアルプロジェクトの環境です。

## 概要（日報）
### 2024/04/16

#### やったこと
- 環境構築
  - macのパッケージマネージャー(hoomebrew)により各種アプリケーションをインストールした
  - git で init / add / commit までを行った
  - github でレポジトリの新規作成から、git remote と clone/push までを行った
  - ssh-keygenにより公開鍵と秘密鍵を作成し、githubにssh接続を行なった。
- マークダウン記法
  - マークダウン形式でドキュメントを記述した
- リモートインスタンス環境へのアクセス
  - いただいた秘密鍵を元にリモートインスタンス環境へのsshアクセスを行なった。

#### 新しく学んだこと
- githubへのアクセス方法についてデスクトップを使ったGUIとコマンドラインのCUIの2種類でアクセスする方法を改めて整理できた
- 公開鍵認証の方式について改めて仕組みを復習した
- マークダウン記法でどうすれば見やすくできるかを考えることができた

#### 課題・TODO
- sshキー設定を行なっていないのになぜ自分はgithubレポジトリにpushできたのかを知りたい。
- マークダウンで設定方法等を細かく記述し過ぎてしまっている。適切な情報整理を心がけたい。

### 2024/04/17

#### やったこと
- Linux操作
  - 基本のコマンドライン操作
  - 権限変更
  - ファイルの解凍・圧縮操作
  - ローカルからのファイルの転送・受信
- ネットワーク
  - グローバルIPとローカルIPアドレスの違いと確認方法
  - pingコマンドによる通信確認

#### 新しく学んだこと
- 権限変更について、ユーザ/ユーザグループ/その他の３つに対する権限の違いとread/write/execの権限種類の違いについて詳しく理解できた。
- ファイルの圧縮方法についてCUI操作は初めて知った。またtarとzipの違いについても初めて知った。
- IPアドレスについてグローバルとローカルの違いをふわっとしていた理解がしっかりしたものになった。
- pingコマンドがどういうものかを理解できた。

#### 課題・TODO
- `.ssh`の権限設定について適切な権限設定とその根拠を知りたい。
- `chmod`の4桁での指定方法について知りたい。
- シンボリックリンクについて原理と用途を知りたい
- `ifconfig`コマンドで出力されるネットワーク周りの情報について詳しく知りたい
- グローバルIPの確認方法は外部サイトにアクセスするしかないのか。他の方法を知りたい。
- インスタンスへ`ping`が通らない理由を知りたい。
- そもそも`ping`は何をしているのかを詳しく知りたい。

### 2024/04/18

#### やったこと
- Docker操作の基本
  - Dockerの概念理解
  - Dockerのイメージプルからコンテナの起動
  - Dockerのコンテナ・イメージ管理
  - ホストマシンとコンテナ間のファイル操作
  - インスタンス上でのDocker操作
- Dockerのオプションの理解
  - Dockerの`-i`,`-t`,`-d`オプションについて調査
  - Dockerのデータ管理オプションについて調査

#### 新しく学んだこと
- Dockerの基本操作と概念について詳しく理解し利用できるようになった。
- コンテナがフォアグラウンドプロセスで実行されていないと終了すること、`-i`,`-t`,`-d`オプションについてその意味と用途を詳しく理解した
- コンテナでのデータ管理方法について、volume, mount, tmpfsそれぞれの違いと用途を詳しく理解できた。

#### 課題・TODO
- Docker と VMの違いを内部構造から含めて詳しく説明できるようになりたい。
- DockerFileの記述方法などを詳しく知り、自分で作成できるようになりたい。

## 環境構築

### 必要なパッケージのインストール

#### homebrew
[Homebrew公式サイト](https://brew.sh/)よりインストール：
macのターミナル上で以下のコマンドを実行
```
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
```

#### 各種アプリケーションをダウンロード
ターミナル上でhomebrewのコマンドを実行してインストール

- git: `brew install git`

- github desktop: `brew install --cask github`
- docker: `brew install --cask docker`
- docker-compose: 上記の Docker Desktop をインストール・起動すると自動的にインストールされる

- Visual Studio Code: `brew install visual-studio-code`
- iTerm2: `brew install iterm2`

#### github アカウントの作成
[GitHub公式サイト](https://github.com/)にアクセスするとサインアップ画面が出るので、指示に従って情報を入力してアカウントを作成

### git/github 初期設定
目標：githubの個人のレポジトリでIT基礎研修の作業手順書を公開する。
1. github上で新規のレポジトリとREADME.mdファイルを作成
   1. githubの自身のアカウントのホーム画面（`https://github.com/自分のアカウント名`）へ移動
   2. 「Repositories」タブをクリック
   3. 「New」ボタンをクリック
   4. 新規レポジトリの設定を行う
      1. Repository Name: 任意の名前
      2. Public/Private: Publicを選択
      3. Initialize this repository with: 「Add a README file」にチェック
      4. 「Create repository」をクリック
2. 自分のPC上にクローン
   1. 作成したレポジトリの画面（`https://github.com/自分のアカウント名/作成したレポジトリ名`）へ移動
   2. 「Code」ボタンをクリック
   3. 「HTTPS」タブをクリック
   4. 表示されるURLをコピー
   5. 自分のPC上でターミナルを開く
   6. 任意のディレクトリ（PC上で編集したいディレクトリ）へコマンドを打ち込んで移動: `cd 任意のディレクトリパス `
   7. コマンドを打ち込んでレポジトリをクローンする: `git clone https://github.com/自分のアカウント名/作成したレポジトリ名.git`
3. git操作からレポジトリへpush
   1. PC上にクローンしたディレクトリの`README.md`ファイルを編集する
   2. 自分のPC上でターミナルを開く
   3. クローンしたディレクトリへコマンドを打ち込んで移動: `cd ディレクトリのパス`
   4. gitで`README.md`ファイルの変更をaddする: `git add README.md`
   5. gitで変更をコミットメッセージを追記してcommitする: `git commit -m "任意のコミットメッセージ"`
   6. push先の github レポジトリを追加する: `git remote add origin https://github.com/自分のアカウント名/作成したレポジトリ名.git`
   7. githubへpushする: `git push -u origin master`*1

### github のssh接続設定
参考:
- [Qiita | GitHubでssh接続する手順~公開鍵・秘密鍵の生成から~](https://qiita.com/shizuma/items/2b2f873a0034839e47ce)
- [@ITmedia | 【 ssh 】コマンド――リモートマシンにログインしてコマンドを実行する](https://atmarkit.itmedia.co.jp/ait/articles/1701/26/news015.html)
- [@ITmedia | 【 ssh-keygen 】コマンド――SSHの公開鍵と秘密鍵を作成する](https://atmarkit.itmedia.co.jp/ait/articles/1908/02/news015.html)

1. sshの秘密鍵と公開鍵を作成する
   1. `~/.ssh/` 配下でsshキーペアを作成:  `ssh-keygen -t rsa`
   2. 鍵の名前を任意に設定する: `Enter file in which to save the key (/Users/(username)/.ssh/id_rsa):任意の名前`
2. 公開鍵をgithubに登録する
   1. クリップボードに公開鍵をコピー: `pbcopy < 設定した鍵の名前.pub`
   2. [githubのssh設定画面](https://github.com/settings/ssh)から公開鍵を登録
3. sshの接続方法を設定する
   1. `~/.ssh/config`を作成し以下を記述
```
Host github github.com
  HostName github.com
  IdentityFile ~/.ssh/設定した鍵の名前
  User git
```
4. gitの接続方法の設定を変える
   1. push先のgithubレポジトリをssh方式に変更する: `git remote set-url origin github:GitHubのユーザ名/リポジトリ名.git`
   2. 接続を確認

## Linux操作とネットワーク
### リモートインスタンス環境へのsshアクセスの設定
#### 天下り的に
1. 秘密鍵ファイルを`~/.ssh`配下に移動させ権限を設定。
2. ユーザ名とインスタンスのIPアドレスを指定してssh通信:　`ssh -i 移動させた秘密鍵ファイルパス ユーザ名@インスタンスのIPアドレス`
   - 初回はパスワードの設定を求められ、2回同じパスワードを入力し、パスワードが正常に設定されると、自動的にログアウトされる。

#### 自分のssh鍵での接続
1. ローカルの`~/.ssh`配下でsshキーペアを作成: `ssh-keygen`
2. 鍵の名前を任意に設定する: `Enter file in which to save the key (/Users/(username)/.ssh/id_rsa):任意の名前`
3. 作成された公開鍵ファイルをインスタンス側に送信する([ファイル転送](#ファイル転送)参照): `scp ~/.ssh/作成した鍵名.pub 送信先`
4. インスタンス側で転送された公開鍵ファイルの内容を`~/.ssh/authorized_keys`に追記する: `cat 転送した公開鍵ファイル.pub >> ~/.ssh/authorized_keys`
   - ＊`>>`ではなく`>`にすると上書きになってしまうので注意
5. ローカルからssh接続可能かを確認する: `ssh -i ~/.ssh/作成した秘密鍵ファイル ユーザ名@インスタンスのIPアドレス`

#### sshの設定
TODO



### コマンドライン操作
#### 基本操作
- ファイル操作: `cd`, `ls`, `pwd`, `mkdir`, `rm`, `rmdir`, `touch`, `cp`, `mv`
- ファイル編集・検索・内容確認: `vim`, `cat`, `less`, `grep`, `head`, `tail`, `diff`, `wc`
- その他: `*` `?`(ワイルドカード), `|`(パイプ), `>`(リダイレクト)

#### 権限設定
参考:
- [Qiita | Linuxの権限確認と変更(chmod)（超初心者向け）](https://qiita.com/shisama/items/5f4c4fa768642aad9e06)
- [Qiita | 「sudo su」ってざっくり言ってなんぞ？ #Linux](https://qiita.com/msht0511/items/31294277a4415ccb4ac9)
- [IT用語辞典 e-Words | 実行権限とは - 意味をわかりやすく](https://e-words.jp/w/%E5%AE%9F%E8%A1%8C%E6%A8%A9%E9%99%90.html)

権限操作コマンド
- `sudo`: 管理者権限でコマンドを実行
- `su`: ユーザの変更
- `ls -l`: フォルダ内のものについて権限などの状態も含めたリスト表示
- `chmod`: 対象の権限を変更
- `chown`: 対象の管理者を変更

Tips:
- `chmod`の数字指定は3桁の2進数が由来: 100 -> 4, 020 -> 2, 001 -> 1

#### ファイル圧縮・解凍
参考:
- [Qiita | [Linux]ファイルの圧縮、解凍方法](https://qiita.com/supersaiakujin/items/c6b54e9add21d375161f)

Tips:
- `tar`は権限は圧縮した時のまま、`zip`は解凍すると権限が変わってしまう。そのため環境を保持するためtarを推奨

#### ファイル転送
参考:
- [Qiita | scpコマンドでサーバー上のファイルorディレクトリをローカルに落としてくる](https://qiita.com/katsukii/items/225cd3de6d3d06a9abcb)
  - ＊今回のワークでは`scp`コマンドの`-i`オプションで秘密鍵を指定する必要がある
  - ＊sshのconfig設定をしていれば`ホスト名:リモートのコピー先パス`で指定可能

### ネットワーク操作
#### グローバルIPアドレスとローカルIPアドレス
参考:
- グローバル/ローカルIPアドレスとは
  - [情シスマン | グローバルIPアドレスとプライベートIPアドレスの違いとは？【初心者向け・図解付】](https://www.gate02.ne.jp/media/it/column_98/)
- サブネットマスクとは
  - [JITERA | サブネットとは？IPアドレスの範囲やサブネットマスクの計算など基本の知識を徹底解説](https://jitera.com/ja/insights/20594)
  - [CMAN |サブネットマスクとは？](https://www.cman.jp/network/term/subnet/p3/)
- ローカルIPの確認方法
  - ifconfig
    - [Hatena Blog | ターミナルからプライベートIPアドレスとMACアドレス、ルーティングテーブルを確認する](https://bambinya.hateblo.jp/entry/2015/04/04/234428)
    - [Qiita | macOSでifconfigコマンドを使用してネットワークインターフェースの情報を確認する](https://qiita.com/fastso/items/db46e03fbacac9b38793)
  - arp
    - [aNote | Macで同一ネットワーク（LAN）上にある機器のIPアドレスを調べる方法](https://anote.work/2244/)
- グローバルIPの確認方法
  - [Qiita | グローバルIPアドレスを最速で調査する方法](https://qiita.com/Brutus/items/3b9d169a4f50c8058816)

グローバル/ローカルIPアドレスとは
- グローバルIPアドレス: インターネット空間で一意に割り当てられる住所
- ローカルIPアドレス: 一つのグローバルIPアドレスを持つ機器を用いて、複数デバイスがインターネット接続する時にグローバルIPアドレスを持つ機器がそれらの複数のデバイスを識別するためにその限定的なネットワーク上だけで一意に割り当てられる住所

ローカルIPの確認方法
1. ターミナル上で`ifconfig`と打つ
2. 出力される情報の内`en0`の`inet`以降に表示されているものがローカルIPアドレス
   - たくさん出力されるので`if config | grep "en0"`などで絞りこんでおくと良い

グローバルIPの確認方法
- 以下に挙げるような確認できるWebサイトにアクセスする
  - https://www.cman.jp/network/support/go_access.cgi
  - https://ipinfo.io/
      - コマンラインで`curl https://ipinfo.io/`でアクセスするとjson形式でインターネット接続情報を返してくれる

#### pingコマンド
参考:
- [@ITmedia | Windowsの「ping」コマンドでネットワークトラブルの原因を調査する](https://atmarkit.itmedia.co.jp/ait/articles/0012/01/news002.html)

`ping`コマンドによる通信確認方法
- インスタンスとの疎通確認: `ping インスタンスのグローバルIP`
- 他者のPCとの疎通確認: `ping 他者のローカルIP`
- yahooサイトとの疎通確認: `ping yahoo.com`

## Docker
### Dockerについて
#### Dockerとは
コンピュータ上に仮想的なプログラム実行環境を作成するシステム。

#### Dockerのメリット
- プログラムの実行環境を共有することができる。
- 実験的な実行環境を作成することができる。

### Dockerの基本操作
#### Dockerでコンテナの起動まで
1. DockerHub上からubuntuのイメージをローカルにダンロードする: `docker pull ubuntu`
2. ubuntuのイメージからコンテナを作成し、ターミナルで`bash`の操作ができるようする: `docker run -it ubuntu bash`: 
3. コンテナ内での操作
  - `apt-get update && apt-get install -y vim`: vimをインストール
  - `vim`, `ls`, `cd`など基本のコマンドが使えることを確認

Tips:
- `docker run [オプション] イメージ名 実行コマンド`
  - 主要なオプション:
    - `-i`オプション: ホスト側の標準入力をコンテナ側の標準入力と繋げる
    - `-t`オプション: tty(端末デバイス)を割り当て、コンテナ側の標準出力をホスト側の標準出力と繋げる
    - `-d`オプション: コンテナをバックグラウンドで実行
- プロセスとコンテナの挙動について
  - 一つのコンテナに対して必ず一つ以上のプロセスを実行しないといけない
  - コンテナのフォアグラウンドでプロセスが動いていない場合、コンテナは正常終了する
    - bashのプロセスは標準入力か出力が繋がってないと終了する。
  - docker run でコマンドを何も指定してなくても動くのは、イメージ単位でデフォルト指定がある。例えば[ubuntuイメージ](https://hub.docker.com/layers/library/ubuntu/latest/images/sha256-6f6ec53d36a9504f01e3636cf68e0e03761a3b6947a95ba430ae553ee3aaf4d9?context=explore)では`/bin/bash`

#### Dockerのコンテナ・イメージ管理
- Dockerのコンテナの状態表示
  - 起動中のコンテナを表示する: `docker ps`
  - 停止中のコンテナも含めて全てのコンテナを表示する: `docker ps -a`
  - 表示項目について
    - CONTAINER ID: コンテナを識別するID。作成時に自動的に作成される。
    - IMAGE: コンテナのもとになっているイメージ
    - COMMAND: コンテナ作成時に行ったコマンド
    - CREATED: 作成日時
    - STATUS: 起動中`Up`か停止中`Exited`か
    - PORTS: ホストマシンとの通信のポート
    - NAMES: コンテナの名前
- コンテナの停止・再開・削除
  - 起動中のコンテナの停止: `docker stop`
  - 停止中のコンテナの再開: `docker start`
  - 停止中のコンテナの削除: `docker rm コンテナIDまたはコンテナ名`
- ローカルにpullされているDockerのイメージを表示する: `docker images`

#### ホストマシンとコンテナ間のファイル操作
＊前提として操作対象のコンテナは起動しているものとする
- `docker cp`を使ってコンテナとホストマシン間でファイルをコピーする
  - コンテナのファイルをホスト側にコピー: `docker cp コンテナID:コンテナ内パス ホスト内パス`
  - ホスト側のファイルをコンテナ側にコピー: `docker cp ホスト内パス コンテナID:コンテナ内パス`
- `-v`オプションを使ってホスト側のフォルダとコンテナ側のフォルダをマウントする。
  - `docker run -v ホスト内パス:コンテナ内パス`

Tips:
- Dockerのデータ管理方法
  - [volume](https://matsuand.github.io/docs.docker.jp.onthefly/storage/volumes/): Dockerが管理するコンテナに依存しない永続データ保存場所のデータをコンテナにマウント(共有)する
  - [mount](https://matsuand.github.io/docs.docker.jp.onthefly/storage/bind-mounts/): ホストマシンの特定フォルダ・ファイルをコンテナにマウント(共有)する
  - [tmpfs](https://matsuand.github.io/docs.docker.jp.onthefly/storage/tmpfs/): ホストマシンのメモリの一時的なデータ保存場所のデータをコンテナにマウントする

#### インスタンス上でのDocker操作
Dockerがインスタンス上にすでにインストールされているため、基本的にインスタンスにssh接続すれば、上記と同様のDocker操作が可能
＊一つのインスタンスで複数のユーザがDocker操作を行うと、pullしたイメージ、作成したコンテナなどは共有される点は注意

## 疑問点
- [ ] *1 sshキー設定を行なっていないのになぜ自分はgithubレポジトリにpushできたのか
  - github desktopで認証が済んだか？
  - VScode でgithub操作をするために認証をしたときに設定されたか？

- [ ] インスタンス->ローカル,ローカル->インスタンスどちらも `ping`が通らないのはなぜ？
  - -> pingが通ると攻撃対象として認識されるので、サーバではICMPプロトコルを閉じている。そのため、pingではICMPプロトコルを使って通信確認するのでpingが通らない。
- [ ] `.ssh`の権限設定について適切な権限設定とその根拠は？
- [ ] `chmod`の4桁での指定方法はどういうもの？
- [ ] シンボリックリンクについて原理とその用途は？
- [ ] `ifconfig`コマンドで出力されるネットワーク周りの情報の内容を知りたい。
- [ ] グローバルIPの確認方法は外部サイトにアクセスするしかないのか？
- [ ] そもそも`ping`は何をしているのか？

- [ ] DockerとVMの詳細な違いは？
- [ ] 環境変数の格納場所は？Dockerで環境変数指定で指定した時、どこに書き込まれる？