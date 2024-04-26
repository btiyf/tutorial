# Linux操作とネットワーク
## リモートインスタンス環境へのsshアクセスの設定
### 天下り的に
1. 秘密鍵ファイルを`~/.ssh`配下に移動させ権限を設定。
2. ユーザ名とインスタンスのIPアドレスを指定してssh通信:　`ssh -i 移動させた秘密鍵ファイルパス ユーザ名@インスタンスのIPアドレス`
   - 初回はパスワードの設定を求められ、2回同じパスワードを入力し、パスワードが正常に設定されると、自動的にログアウトされる。

### 自分のssh鍵での接続
1. ローカルの`~/.ssh`配下でsshキーペアを作成: `ssh-keygen`
2. 鍵の名前を任意に設定する: `Enter file in which to save the key (/Users/(username)/.ssh/id_rsa):任意の名前`
3. 作成された公開鍵ファイルをインスタンス側に送信する([ファイル転送](#ファイル転送)参照): `scp ~/.ssh/作成した鍵名.pub 送信先`
4. インスタンス側で転送された公開鍵ファイルの内容を`~/.ssh/authorized_keys`に追記する: `cat 転送した公開鍵ファイル.pub >> ~/.ssh/authorized_keys`
   - ＊`>>`ではなく`>`にすると上書きになってしまうので注意
5. ローカルからssh接続可能かを確認する: `ssh -i ~/.ssh/作成した秘密鍵ファイル ユーザ名@インスタンスのIPアドレス`

### sshの設定
TODO



## コマンドライン操作
### 基本操作
- ファイル操作: `cd`, `ls`, `pwd`, `mkdir`, `rm`, `rmdir`, `touch`, `cp`, `mv`
- ファイル編集・検索・内容確認: `vim`, `cat`, `less`, `grep`, `head`, `tail`, `diff`, `wc`
- その他: `*` `?`(ワイルドカード), `|`(パイプ), `>`(リダイレクト)

### 権限設定
権限操作コマンド
- `sudo`: 管理者権限でコマンドを実行
- `su`: ユーザの変更
- `ls -l`: フォルダ内のものについて権限などの状態も含めたリスト表示
- `chmod`: 対象の権限を変更
- `chown`: 対象の管理者を変更

Tips:
- `chmod`の数字指定は3桁の2進数が由来: 100 -> 4, 020 -> 2, 001 -> 1

参考:
- [Qiita | Linuxの権限確認と変更(chmod)（超初心者向け）](https://qiita.com/shisama/items/5f4c4fa768642aad9e06)
- [Qiita | 「sudo su」ってざっくり言ってなんぞ？ #Linux](https://qiita.com/msht0511/items/31294277a4415ccb4ac9)
- [IT用語辞典 e-Words | 実行権限とは - 意味をわかりやすく](https://e-words.jp/w/%E5%AE%9F%E8%A1%8C%E6%A8%A9%E9%99%90.html)

### ファイル圧縮・解凍
Tips:
- `tar`は権限は圧縮した時のまま、`zip`は解凍すると権限が変わってしまう。そのため環境を保持するためtarを推奨

参考:
- [Qiita | [Linux]ファイルの圧縮、解凍方法](https://qiita.com/supersaiakujin/items/c6b54e9add21d375161f)

### ファイル転送
参考:
- [Qiita | scpコマンドでサーバー上のファイルorディレクトリをローカルに落としてくる](https://qiita.com/katsukii/items/225cd3de6d3d06a9abcb)
  - ＊今回のワークでは`scp`コマンドの`-i`オプションで秘密鍵を指定する必要がある
  - ＊sshのconfig設定をしていれば`ホスト名:リモートのコピー先パス`で指定可能

## ネットワーク操作
### グローバルIPアドレスとローカルIPアドレス
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

### pingコマンド
`ping`コマンドによる通信確認方法
- インスタンスとの疎通確認: `ping インスタンスのグローバルIP`
- 他者のPCとの疎通確認: `ping 他者のローカルIP`
- yahooサイトとの疎通確認: `ping yahoo.com`

参考:
- [@ITmedia | Windowsの「ping」コマンドでネットワークトラブルの原因を調査する](https://atmarkit.itmedia.co.jp/ait/articles/0012/01/news002.html)
