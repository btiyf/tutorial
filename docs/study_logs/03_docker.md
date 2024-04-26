# Docker
## Dockerについて
### Dockerとは
コンピュータ上に仮想的な独立したプログラム実行環境を作成するシステム。
また、Dockerイメージとはその実行環境を作成する元となる設計書のようなものであり、
DockerコンテナとはDockerイメージを元に作成された実行環境である。

### Dockerのメリット
- プログラムの実行環境を共有することができる。
- 実験的な実行環境を作成することができる。

## Dockerの基本操作
### Dockerでコンテナの起動まで
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

参考:
- [Qiita | Dockerコンテナの作成、起動〜停止まで](https://qiita.com/kooohei/items/0e788a2ce8c30f9dba53)
- [minato | docker runのオプションいろいろ](https://scrapbox.io/llminatoll/docker_run%E3%81%AE%E3%82%AA%E3%83%97%E3%82%B7%E3%83%A7%E3%83%B3%E3%81%84%E3%82%8D%E3%81%84%E3%82%8D)
- [- | dockerのrunコマンドのオプション一覧](https://minegishirei.hatenablog.com/entry/2023/05/09/095603#docker--v---volume)
- [- | docker run -it で学ぶ tty とか標準入出力とかファイルディスクリプタとか](https://ohbarye.hatenablog.jp/entry/2019/05/05/learn-tty-with-docker)
- [- | Linux コマンド格納場所一覧　と　環境変数（PATHを通すbash_profile）](https://mycodingjp.blogspot.com/2018/10/linuxpathbashprofile.html)

### Dockerのコンテナ・イメージ管理
- Dockerのコンテナの状態表示
  - 起動中のコンテナを表示する: `docker ps`
  - 停止中のコンテナも含めて全てのコンテナを表示する: `docker ps -a`
  - 表示項目について
    - `CONTAINER ID`: コンテナを識別するID。作成時に自動的に作成される。
    - `IMAGE`: コンテナのもとになっているイメージ
    - `COMMAND`: コンテナ作成時に行ったコマンド
    - `CREATED`: 作成日時
    - `STATUS`: 起動中`Up`か停止中`Exited`か
    - `PORTS`: ホストマシンとの通信のポート
    - `NAMES`: コンテナの名前
- コンテナの停止・再開・削除
  - 起動中のコンテナの停止: `docker stop`
  - 停止中のコンテナの再開: `docker start`
  - 停止中のコンテナの削除: `docker rm コンテナIDまたはコンテナ名`
- ローカルにpullされているDockerのイメージを表示する: `docker images`

### ホストマシンとコンテナ間のファイル操作
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

参考:
- [Qiita | Dockerでホストとコンテナ間でのファイルコピー](https://qiita.com/gologo13/items/7e4e404af80377b48fd5)

### インスタンス上でのDocker操作
Dockerがインスタンス上にすでにインストールされているため、基本的にインスタンスにssh接続すれば、上記と同様のDocker操作が可能

＊ 一つのインスタンスで複数のユーザがDocker操作を行うと、pullしたイメージ、作成したコンテナなどは共有される点は注意
