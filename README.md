<img src="https://user-images.githubusercontent.com/57985382/84869518-1bcbc980-b0b9-11ea-9e14-1ac69271f035.PNG" width="50%">

## 内容
このアプリは、英単語もしくは英文のタイピング練習を行うアプリです。<br>
タイピング練習を通して英単語や英文を覚え、英語の読解力向上に繋げる為に作りました。

## URL
[https://gametyping.herokuapp.com/](https://gametyping.herokuapp.com/)

## 環境

- フロント
  - Haml
  - JavaScript
  - jQuery
- バックエンド
  - Ruby 2.5.1
  - Rails 5.2.4.1
- インフラ
  - Heroku
  - MySQL 5.5.56
  - AWS S3
<img src="https://user-images.githubusercontent.com/57985382/84886947-10d06380-b0d0-11ea-9376-5b92633e1ea7.png" width="50%">

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
