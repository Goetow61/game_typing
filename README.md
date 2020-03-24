![booksearch](https://user-images.githubusercontent.com/57985382/76777705-f1355080-67eb-11ea-9f5d-51a855d30b0b.png)

## URL
[GameTyping (https://gametyping.herokuapp.com/)](https://gametyping.herokuapp.com/)

## 内容

タイピングの練習ができます。英単語か英文を打つことができます。タイピングスピードでランキングを表示します。

## 環境

Ruby 2.5.1, Rails 5.2.4.1, Mysql 5.5.56
Heroku, AWS S3, VSCode (Visual Studio Code)

## 機能

1. ユーザー登録・編集・ログイン・ログアウト
1. タイピングする問題をCSVファイルで登録
1. タイピングゲーム
1. ランキング表示

## 仕組み

ユーザー管理はdevise gemで行っています。
タイピングする文言は、「"英語文"\t"日本語訳"」の形でCSVファイルとして登録しています。
CSVファイルのアップロードはcarrierwave gemを使い、AWS S3に保存しています。
CSVファイルのダウンロードはcarrierwave gemでURLを取得しダウンロード、Tempfileクラスに保存、Fileクラスで開き、CSVクラスで行列を読み込み、1行ずつ配列変数に代入しています。

配列変数はjavascriptに渡して、javascriptでタイピングゲームを動かしています。
javascriptはクライアントのキー押下で、CSVファイルのダウンロードリクエスト、制限時間の記録、問題文の表示、結果の表示を行っています。

## データベース構造

### usersテーブル

|Column|Type|Options|
|------|----|-------|
|nickname|string|null: false|
|email|string|null: true, unique:true|
|password|string|null: false|

### Association
- has_many :results
- has_many :qfiles

### qfilesテーブル

|Column|Type|Options|
|---|---|---|
|title|string|null: false|
|overview|text||
|src|string|null: false|
|category|integer|null: false|
|user_id|biginteger||

### Association
- belongs_to :user
- has_many :results

### resultsテーブル

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
