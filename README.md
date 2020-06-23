## 英語学習タイピング

<img src="https://user-images.githubusercontent.com/57985382/84977572-9c480400-b165-11ea-9f9b-43bf4c9a9f80.PNG" width="50%">

## 内容
このアプリは、英単語もしくは英文のタイピング練習を行うアプリです。<br>
タイピング練習を通して英単語や英文を覚え、英語の読解力向上に繋げる為に作りました。

## URL
[http://game-typing.work/](http://game-typing.work/)

## 環境

- フロントエンド
  - Haml
  - JavaScript
  - jQuery
- バックエンド
  - Ruby 2.5.1
  - Rails 5.2.4.1
- インフラ
  - AWS(EC2, VPC, ELB, RDS, Route53, S3)
  
<img src="https://user-images.githubusercontent.com/57985382/85371099-b53c2500-b56a-11ea-899a-ae1e6e07a054.png" width="50%">

## 機能要件

- 非ログイン時
  - タイピングゲーム
  - ランキング表示
- ログイン時
  - タイピング履歴保存
  - ユーザー管理
  - タイピングする問題の登録、削除

## 非機能要件

- 非ログイン時のタイピング結果を最新1件のみ、ログイン時に保存

## データベース構造

### usersテーブル

|Column|Type|Options|
|---|---|---|
|nickname |string |null: false|
|email    |string |null: true, unique: true|
|password |string |null: false|

### Association

- has_many: results
- has_many: qfiles

### qfilesテーブル

|Column|Type|Options|
|---|---|---|
|title    |string     |null: false|
|overview |text       ||
|src      |string     |null: false|
|category |integer    |null: false|
|user_id  |biginteger ||

### Association

- belongs_to: user
- has_many:   results

### resultsテーブル

|Column|Type|Options|
|---|---|---|
|user_id      |biginteger ||
|qfile_id     |biginteger ||
|correct_cnt  |integer    |null: false|
|wrong_cnt    |integer    |null: false|
|elapsed_time |decimal    |null: false|
|speed        |decimal    |null: false|

### Association

- belongs_to: user
- belongs_to: qfile
