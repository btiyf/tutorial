# tutorial
IT基礎研修用のプロジェクトです。
- IT基礎研修での学習記録: [docs/study_log](./docs/study_logs)
- 今回の成果物についての詳細: [docs/about.md](./docs/about.md)

## 概要
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

## 構築手順書
IT基礎研修で学んだことをもとに作成したWebサーバーの構築手順を記します。

任意のPCもしくはサーバー上で、本手順書に従うことで最終的には手順を実行したPCもしくサーバーの特定ポートへアクセスするとWebページが閲覧できるようになります。

### 前提
- dockerがインストールされていること
- dockerデーモンが立ち上がっていること
- gitがインストールされていること

### Quick Start
任意の作業用ディレクトリで以下を実行することで、8080番ポートにWebサーバーが立ち上がります。
```bash
$ git clone https://github.com/btiyf/tutorial.git
$ cd ./tutorial
$ sh quick_start.sh
```
### 構築手順（詳細）
1. ターミナルを開き任意の作業用ディレクトリに移動します。
    ```bash
    $ cd 任意のディレクトリパス
    ```

2. GitHub上のこのレポジトリをクローンします。
    ```bash
    $ git clone https://github.com/btiyf/tutorial.git
    ```

3. クローンしたレポジトリ内に移動します。
    ```bash
    $ cd ./tutorial
    ```

4. 以下のコマンドでDockerfileをbuildします。
    ```bash
    $ docker build . -t tutorial
    ```
    ＊`-t tutorial`はイメージの名前を指定しています。
任意の名前に変更しても構いません。

5. 以下のコマンドで作成されたdockerのimageからコンテナを作成・起動します。
    ```bash
    $ docker run -d -p 8080:80 tutorial
    ```
    ＊`-p 8080:80`の`8080`はWebサイトを閲覧する際にアクセスするポート番号を指定しています。任意のポート番号に変更しても構いません。

6. 上記の構築手順を行なったPCまたはサーバーのIPアドレスの指定したポート番号へWebブラウザからアクセスすることで、Webサイトが表示されることを確認してください。
    
    例えば、アクセス先は以下のようになります。
    - ローカル環境で起動する場合: `http://localhost:8080`
    - サーバー上で起動してローカルPCから見る場合: `http://サーバーのグローバルIPアドレス:8080`