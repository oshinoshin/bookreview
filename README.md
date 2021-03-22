# BOOKREVIEW
---

# アプリケーション概要
---
- 本の要約を書くことができる
- たくさんの本に触れることができる
- マイページより、自分の読んだ本を確認することができる

# URL
---
(https://bookreview-34410.herokuapp.com/)

# テスト用アカウント
---
## Basic認証
ID:   shinya
pass: 0420

## テスト用アカウント
email:    test@test.com
password: test1111

# 利用方法
---
トップページから新規登録・ログイン
一覧画面に戻る

投稿するボタンをクリック→投稿フォームを記入し投稿
投稿完了後は一覧画面に戻る

一覧画面から１つの投稿を選択→投稿詳細画面に遷移する
投稿者本人であれば投稿の編集・削除が可能になる
ログインしていれば投稿に関してコメントすることができる

一覧画面右上の投稿検索フォームから本の要約を検索できる

# 課題解決
---


# 機能一覧
---
| 機能                 | 概要                                         |
| -------------------- | -------------------------------------------- |
| ユーザー管理機能     | 新規登録・ログイン・ログアウトが可能         |
| 投稿機能             | 画像付きで本のタイトルとレビューの投稿が可能 |
| 投稿検索機能         | 本のタイトルから検索が可能                   |
| 投稿詳細表示機能     | 各投稿詳細が詳細ページで閲覧可能             |
| ユーザー詳細表示機能 | 各ユーザーのレビューは閲覧可能               |
| コメント機能         | 投稿詳細ページからコメントが可能             |
| いいね機能           | 各投稿へいいねをつけることが可能             |

# 実装予定の機能
---
- ユーザー詳細機能にプロフィールを掲載する機能を実装予定

# データベース設計
---
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