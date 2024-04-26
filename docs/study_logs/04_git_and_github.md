# Git/GitHub
## Git/GitHbについて
### Gitとは
Gitとは対象ディレクトリ内のファイル/フォルダの変更履歴・バージョン管理を行うソフトウェア。
### GitHubとは
GitHubとは複数人で共有しているオンライン上のディレクトリにおいて、Gitによる変更履歴・バージョン管理を複数人で管理できるようにしたオンライン上のサービス。

## Gitの基本操作
### 新規レポジトリ作成からコミットまで
1. 新規のレポジトリを作る: 新しくgitのプロジェクトを開始したいディレクトリ内で`git init`
2. 変更を加えてコミットする: `git add 対象ファイル` -> `git commit -m "コミットメッセージ"`
3. コミットされたことを確認する: `git log`
4. コミットを取り消したりする: `git reset --soft ^HEAD`

Tips:
- コミットメッセージのお作法として、最初の行は50文字以内。一行開けて３行目から詳しい記述を行う。
- 直前のコミットメッセージの修正: `git commit --amend`
- git resetのオプションは3つ
  - `--soft`: コミットをStagedに戻す
  - `--hard`: コミットもその変更も全て無かったことにする
  - `--mixed`: コミットをChangedに戻す
- gitの履歴を見るときの便利コマンド
  - `git log --oneline`: logが１行の要約で全て表示される。見やすい。
  - `git show コミットID`: コミット内容まで詳しくみる。

参考:
- [Hatena Blog | コミットの修正には git commit --amend が便利](https://tech-blog.rakus.co.jp/entry/20191113/git)
- [Qiita | [git reset (--hard/--soft)]ワーキングツリー、インデックス、HEADを使いこなす方法](https://qiita.com/shuntaro_tamura/items/db1aef9cf9d78db50ffe)

### ブランチ作成とマージ
1. 新規ブランチを作成してそのブランチに移動: `git checkout -b 新規ブランチ名`
2. 現在のブランチを確認: `git branch`
3. 変更を加えてコミットする: `git add 変更したファイル`, `git commit -m "コミットメッセージ"`
4. 変更をmainブランチにマージする
   1. mainブランチに移動する: `git checkout main`
   2. 変更をmainブランチにマージする: `git merge ブランチ名`

### 変更の退避
あるブランチの変更内容はコミット前に他のブランチに移動してしまうと、他のブランチに持ち越されてしまう。ただし、変更が他のブランチとコンフリクトする場合は警告が出てブランチを変更できない。
持ち込まれないようするためには`git stash`を使う。
1. 変更内容の持ち込み: 変更をコミット前にブランチを移動する
```bash:ターミナル
$ git branch # mainブランチにいることを確認
$ touch test.txt
$ git add test.txt && git commit -m "test.txtを追加"
$ git checkout -b test1
$ echo "hello from test1 branch" > test.txt
$ git status # test.txtの変更を確認
$ git checkout main
$ git status # test.txtの変更が持ち越されてしまっている。
```
2. ブランチ変更不可: 別のブランチでコミット済みのファイルで現在のブランチで反映されていないファイルを新たに作成して、コミット前にブランチを移動する
```bash:ターミナル
$ git branch # mainブランチにいることを確認
$ git branch test2 #ファイルを作成する前にブランチを作成する
$ touch test.txt
$ git add test.txt && git commit -m "test.txtを追加"
$ git checkout test2
$ echo "hello from test2 branch" > test.txt # git mergeでは自動解消可能なconflictだが、ブランチ変更ではgit mergeほど賢くない
$ git status # test.txtの変更を確認
$ git checkout main # エラーで変更できない
```
3. `git stash`を使って1,2の問題を解決する
   1. それぞれ`git checkout main`の前に変更を退避させる: `git stash -u`
   2. 元のブランチに戻ってきた時、退避させた作業をもとに戻す: `git stash pop stash@{0}`

参考:
- [Qiita | 【git stash】コミットはせずに変更を退避したいとき](https://qiita.com/chihiro/items/f373873d5c2dfbd03250)

### コンフリクトの解消
1. mainブランチで`test.txt`を編集しコミットする。
```bash:ターミナル
$ git branch # mainブランチにいることを確認
$ echo "Hello from main branch" > test.txt
$ git add test.txt && git commit -m "test.txtをmainブランチで編集"
```  
2. 別のブランチで`test.txt`を編集しコミットする。
```bash:ターミナル
$ git branch # 別のブランチにいることを確認
$ echo "Hello from the other branch" > test.txt
$ git add test.txt && git commit -m "test.txtを別のブランチで編集"
``` 
4. 変更をmainブランチにコミットする
   1. mainブランチに移動する: `git checkout main`
   2. 変更をmainブランチにマージする: `git merge ブランチ名`
   3. 以下のようにコンフリクトが起こり、コンフリクト解消モードになる。
```txt:ターミナル
$ git merge 
Auto-merging test.txt
CONFLICT (content): Merge conflict in test.txt
Automatic merge failed; fix conflicts and then commit the result.
$ git status
On branch main
You have unmerged paths.
  (fix conflicts and run "git commit")
  (use "git merge --abort" to abort the merge)

Unmerged paths:
  (use "git add <file>..." to mark resolution)
	both modified:   test.txt

no changes added to commit (use "git add" and/or "git commit -a")
```
5. コンフリクトした部分は以下のように表示されるので内容を確認してファイルを修正する。
```
$ cat test.txt
<<<<<<< HEAD
Hello from main branch
=======
Hello from the other branch
>>>>>>> 別のブランチ名
```

6. 修正を加えたファイルをコミットする: `git add test.txt && git commit -m "コミットメッセージ"`
   - ここでのコミットメッセージはマージとコンフリクトを解消したことを明示した方が良い
7. マージが完了し、マージした別のブランチの変更履歴も統合されていることを確認する: `git log`

参考:
- [Qiita | Git コンフリクト解消手順](https://qiita.com/crarrry/items/c5964512e21e383b73da)
- [Qiita | 【git】マージしたけどやっぱりやめたい時のやり方4種類](https://qiita.com/chihiro/items/5dd671aa6f1c332986a7)
- 

## GithubのPR(Pull Request)まで
他人のレポジトリを共同編集するには2つの方法がある。
- レポジトリの所有者にCollaboratorに追加してもらう
- レポジトリをForkして所有者にPRを送る

今回は後者を行う。

### 他の人のレポジトリのクローンしてPRを送る
1. クローンしたい他人のレポジトリのURLにブラウザでアクセス
2. "Fork"というボタンを押して自分のレポジトリとしてコピーする。
3. Forkしたレポジトリをローカル上にクローンする: `git clone 自分のレポジトリのURL`
4. ローカル上にクローンしたレポジトリに変更加えてコミットする。
5. Forkした自分のレポジトリへプッシュする。
6. Forkした自分のレポジトリのURLにブラウザでアクセスして、Fork元の他人のレポジトリにPull Requestを作成する。

参考:
- [Qiita | リポジトリのcloneとforkの違い](https://qiita.com/matsubox/items/09904e4c51e6bc267990)
- [Qiita | 【初心者向け】git fetch、git merge、git pullの違いについて](https://qiita.com/wann/items/688bc17460a457104d7d)
- [Qiita | Githubでチーム開発するためのマニュアル](https://qiita.com/siida36/items/880d92559af9bd245c34)
- [@ITmedia | 【図解】git-flow、GitHub Flowを開発現場で使い始めるためにこれだけは覚えておこう](https://atmarkit.itmedia.co.jp/ait/articles/1708/01/news015.html)


### Pull Request後のワークフロー
- PRを承認する側（レビューワー）
 - コードの変更箇所を確認してコードに対して"Approve" / "Request Changes" / "Comment"を選択してコメントをつける。
 - "Approve"を送ったら、PR申請者がマージする。
- PRを申請した側
 - レビューワーから"Request Changes"を受けた -> コードを変更する
   - 修正方法1: ローカルで変更->コミット->プッシュして再度PRを送ると自動的に前のPRに統合される
   - 修正方法2: ブラウザ上でPR画面からコードを直接修正する
 - レビューワーから"Approve"を受けた ->  PRをマージする

参考:
- [Github レビューでの Approve / Request Changes / Comment の使い方](https://qiita.com/YumaInaura/items/8223add6d8335a2eda7f)
