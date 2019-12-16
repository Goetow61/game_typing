## english_phrasesテーブル

|Column|Type|Options|
|------|----|-------|
|phrase|string|null: false|

### Association

## usersテーブル

|Column|Type|Options|
|------|----|-------|
|name|string|null: false|
|email|string|null: true, unique:true|
|password|string|null: false|

### Association
- has_many :results

## resultsテーブル

|Column|Type|Options|
|------|----|-------|
|accurate_count|integer|null: false|
|wrong_count|integer|null: false|
|elapsed_time|float(,2) unsigned|null: false|

### Association
- belongs_to :user