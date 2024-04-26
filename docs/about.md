# 成果物について
今回の成果物についての説明です。

## 今回のゴールと成果物の概要
### 今回の研修のゴール
```
EC2上の任意インスタンス上にdocker上でwebサーバ（nginx）が稼働し、ブラウザからアクセスすると動きのあるページが閲覧できる
- コンテナは決められたEC2インスタンスで稼働する
- あらかじめ決めたれた条件（ポート等）を満たしている
- 稼働した元となるコード（index.htmlやDockerファイル等）はGitHub上にアップロードされている
- README.mdがあり、そこには構築が記載され、環境が再現可能
```
### 自分が作成した成果物の概要
Reactでbuildした静的なWebページを閲覧できる、
NginxによるWebサーバーを構築できる環境をGithubで公開した。
具体的には以下の3つを行なった。
- NginxによるWebサーバー機能を持つDockerイメージを提供する、Ubuntuイメージ元にしたDockerfileを作成
- Reactによる開発環境とBuildした静的なWebページを作成
- 作成したWebサーバーの環境を再現できるように、Github上で手順書と共に公開

## 利用した技術の説明
### Docker
#### Dockerとは
今回はWebサーバーの機能を持つDockerイメージを作成することでWebサーバーの環境を構築している。
Dockerとはコンピュータ上に仮想的な独立したプログラム実行環境を作成するシステム。
また、Dockerイメージとはその実行環境を作成する元となる設計書のようなものであり、
DockerコンテナとはDockerイメージを元に作成された実行環境である。

#### 今回利用しているDocker技術の説明
- Dockerfile
  - Ubuntuイメージにnginxを導入して、フォアグラウンドでnginxのプロセスを起動するイメージを作成する
- Dockerのコマンドについて
  - `docker build . -t tutorial`: 現在のディレクトリにあるDockerfileを元に`tutorial`という名前のイメージを作成する
  - `docker run -d -p 8080:80 tutorial`: `tutorial`という名前のイメージを元にしてコンテナを作成し、実行する
    - `-d`: このオプションを渡すことでホストマシン側のバックグラウンドプロセスとして実行される
    - `-p 8080:80`: このオプションを渡すことでホストマシン側の8080番ポートと80番ポートを繋いでいる。
    今回は`tutorial`のDockerイメージのnginxが80番ポートでListenしているので80番ポートを指定している。

### Nginx
#### Nginxとは
Webサーバーの機能を提供できるオープンソースのソフトウェア。

#### Nginxの設定について
- Listenするデフォルトのポート番号は80番に設定されておりそのまま利用する。
- Webページコンテンツについて、デフォルトでは`/var/www/html`内が設定されているため、今回はここにコンテンツを配置する。

### Webページ表示とReact
#### Reactとは
Javascriptフレームワークの一つでコンポーネントベースのUI開発を行う言語である。

#### ReactによるWebページの作成について
- dockerによる開発環境の構築
  - nodeイメージを用いて開発環境を構築した。
- Reactプロジェクトの開始
  - `docker-compose run --rm node sh -c 'npx create-react-app react-app --template typescript`
    - `--rm`: コマンド実行後コンテナを削除する
    - `sh -c 'npx create-react-app react-app --template typescript`: 
    コンテナのシェルで`npx`の`create-react-app`コマンドで`react-app`という`typescript`ベースのプロジェクトを作成する
- ReactプロジェクトのBuild
  - `docker-compose run --rm node sh -c 'npm run build`:
  プロジェクトを静的なHTML/CSS, javascriptに変換する

### Git/GitHub
#### Git/Githubとは
Gitとは対象ディレクトリ内のファイル/フォルダの変更履歴・バージョン管理を行うソフトウェア。

GitHubとは複数人で共有しているオンライン上のディレクトリにおいて、Gitによる変更履歴・バージョン管理を複数人で管理できるようにしたオンライン上のサービス。

#### Git/GitHubの操作
- Gitによる変更履歴の追跡
  - `git init`, `git add`, `git commit`による操作
- Gitのブランチ操作
  - `git branch`, `git checkout`による操作
  - バージョンを管理するためのブランチの切り分けとマージによる開発
- GitHubでの公開
  - `git push`: GitHub上のレポジトリにローカルの変更を同期させる
  - `git clone`: アクセス権があるレポジトリを自分のローカルにダウンロードする

## 工夫した点
### Dockerfileの利用
- Nginxの公式イメージを使わずに、DockerfileでUbuntuイメージをもとにNginxの環境を持つイメージを作成した

### Reactの利用
- Webページコンテンツを作成するためReactを用いて静的コンテンツを作成した。
  - Reactの開発環境をDockerで構築してローカルをクリーンに保った。
  - Reactによって静的コンテンツをbuildした。

### Git/GitHubによるバージョン管理
- Gitのブランチを用いて、バージョン管理を行なった。

### ドキュメンテーションの徹底
- 勉強したこと、疑問に思ったこと、とにかく整理しながらめっちゃ書いた。