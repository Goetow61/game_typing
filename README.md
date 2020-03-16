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