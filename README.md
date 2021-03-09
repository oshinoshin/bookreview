## users テーブル

| Column     | Type    | Options   |
| ---------- | ------- | --------- |
| email      | string  | NOT NULL  |
| password   | string  | NOT NULL  |
| name       | string  | NOT NULL  |
| profile    | text    | NOT NULL  | 

### Association
- has_many :books
- has_many :comments


## books テーブル

| Column     | Type      | Options                    |
| ---------- | --------- | -------------------------- |
| title      | text      | NOT NULL                   |
| review     | text      | NOT NULL                   |
| image      | image     |                            | 
| user       | reference | foreign_key: true          | 

### Association
- has_many   :comments
- belongs_to :user


## comments テーブル

| Column     | Type      | Options                    |
| ---------- | --------- | -------------------------- |
| text       | text      | NOT NULL                   |
| user       | reference | foreign_key: true          |
| book       | reference | foreign_key: true          |

### Association
- belongs_to :book
- belongs_to :user