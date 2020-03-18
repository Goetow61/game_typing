![booksearch](https://user-images.githubusercontent.com/57985382/76777705-f1355080-67eb-11ea-9f5d-51a855d30b0b.png)

## URL
[GameTyping](https://gametyping.herokuapp.com/)

## 内容

英語をタイピング練習することができます。
問題文は、単語と文章を用意しています。
タイプしたキーの正否によって文字色を変化させ、表示した語句を全て打ち終えると次の語句が表示されます。30秒経過するまでランダムで語句を表示し続けます。ゲームをする前にユーザー登録をしてから行います。タイプしたスピードによってランキングを表示します。

## 開発環境

- Ruby on Rails
- AWS S3
- VSCode (Visual Studio Code)

## 機能

1. ユーザー登録・編集・ログイン・ログアウト
ユーザー登録及び、ユーザー情報の編集などができます。

1. 問題文の登録
タイピングする問題をCSVファイルで登録することができます。

1. タイピングゲーム
任意の問題文を選択することで、タイピングゲームを行うことができます。

1. ランキング機能
タイピングゲームの結果をランキング表示します。

## 仕組み

ユーザー登録回りは、devise gemで作成しています。
タイピングゲームは、Javascriptdで動かしています。
問題文は、carrierwave gemでCSVファイルをS3にアップロードしておき、タイピングゲームを行う時にダウンロード読み込みしています。

## 動作環境

- Ruby 2.5.1
- Rails 5.2.4.1

# データベース構造

## usersテーブル

|Column|Type|Options|
|------|----|-------|
|nickname|string|null: false|
|email|string|null: true, unique:true|
|password|string|null: false|

### Association
- has_many :results
- has_many :qfiles

## resultsテーブル

|Column|Type|Options|
|------|----|-------|
|user_id|biginteger||
|qfile_id|biginteger||
|correct_cnt|integer|null: false|
|wrong_cnt|integer|null: false|
|elapsed_time|decimal|null: false|
|speed|decimal|null:false|

### Association
- belongs_to :user
- belongs_to :qfile

## qfilesテーブル

|Column|Type|Options|
|---|---|---|
|title|string|null: false|
|overview|text||
|src|string|null: false|
|category|integer|null: false|
|user_id|biginteger||