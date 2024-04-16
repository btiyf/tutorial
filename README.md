# tutorial
IT基礎研修用のチュートリアルプロジェクトの環境です。

## 環境構築

### 必要なパッケージのインストール

#### homebrew
(公式サイト)[https://brew.sh/ja/]よりインストール：
macのターミナル上で以下のコマンドを実行
```
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
```

#### 各種アプリケーションをダウンロード
ターミナル上でhomebrewのコマンドを実行してインストール

- git : `brew install git`

- github desktop : `brew install --cask github`
- docker : `brew install --cask docker`
- docker-compose : 上記の Docker Desktop をインストール・起動すると自動的にインストールされる

- Visual Studio Code : `brew install visual-studio-code`
- iTerm2 : `brew install iterm2`

#### github アカウントの作成
(github公式サイト)[https://github.com/]にアクセスするとサインアップ画面が出るので、指示に従って情報を入力してアカウントを作成
