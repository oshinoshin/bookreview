# 📕 BOOKREVIEW
![Image from Gyazo](https://github.com/oshinoshin/bookreview/blob/729d3c11e8e67da9f866f2be0aa937206621aa84/readme1.gif)

# 🗓 アプリケーション概要

- 本の要約を書くことができる
- たくさんの本に触れることができる
- マイページより、自分の読んだ本を確認することができる


# 💭 アプリケーション制作の背景

私は、知識量を増やしたり、視野を広げ自分のアクションプランを決めていくために読書は欠かせないものであると考えます。しかしながら、日本の社会人の読書量は年々減っており、約60％の人が月に一冊も本を読んでいません。また、調べてみると読書をしない理由に、「仕事が忙しく、本を読んでいる時間がない」という理由が一番多い事がわかりました。そこで私は、「本が手軽に楽しめれば、読書をする社会人が増えることにつながるのではないか」という仮説を立て、このアプリを制作することを決めました。


# 🌐 URL

(https://bookreview-34410.herokuapp.com/)


# 🙋‍♂️ テスト用アカウント

email:    test@test.com  
password: test1111  


# 💻 利用方法

- トップページから新規登録・ログイン  
- 一覧画面に戻る  
[![Image from Gyazo](https://i.gyazo.com/d8dcec8f675cd2c0adbe57d39eef66ce.gif)](https://gyazo.com/d8dcec8f675cd2c0adbe57d39eef66ce)


- 投稿するボタンをクリック→投稿フォームを記入し投稿  
- 投稿完了後は一覧画面に戻る  
[![Image from Gyazo](https://i.gyazo.com/4b8098e769f11b24f6a2786d97eb54c5.gif)](https://gyazo.com/4b8098e769f11b24f6a2786d97eb54c5)

- 一覧画面から１つの投稿を選択→投稿詳細画面に遷移する  
- 投稿者本人であれば投稿の編集・削除が可能になる  
- ログインしていれば投稿に関してコメントすることができる  
![Image from Gyazo](https://github.com/oshinoshin/bookreview/blob/b7bd1df9e1bbb9011ca3cdf6f26153308d57fa0a/readme4.gif)

- 一覧画面右上の投稿検索フォームから本の要約を検索できる
[![Image from Gyazo](https://i.gyazo.com/3237b96bf27eeadaec2ec2e7dacee782.gif)](https://gyazo.com/3237b96bf27eeadaec2ec2e7dacee782)


# 📝 課題解決

解決したい課題
- 子供から大人まで、さまざまな人々の読書量や読書時間を増やす

読書は子供から大人までが学べるものです。しかし、日本人一人当たりの読書量や読書時間は年々減っています。また、読書量が減っている理由として、「仕事や勉強が忙しくて読む時間がない」「情報機器で時間が取られる」といった理由が挙げられます。

読書には、知識量を増やしたり、視野を広げ自分のアクションプランを決めることができたり、さまざまなメリットがあります。にも関わらず、読書量が減っているのはもったいないように感じ、「子供から大人まで、さまざまな人々の読書量や読書時間を増やす」という課題を解決するためにアプリを開発しました。


# ✅ 洗い出した要件

- 時間がない人でも手軽に本の内容を知ることができる
- レビュー（アウトプット）を通して本の内容を定着させる
- 自分の読んだ本の内容を保存しておくことができる


# 📦 機能一覧

| 機能                 | 概要                                         |
| -------------------- | -------------------------------------------- |
| ユーザー管理機能     | 新規登録・ログイン・ログアウトが可能         |
| 投稿機能             | 画像付きで本のタイトルとレビューの投稿が可能 |
| 投稿検索機能         | 本のタイトルから検索が可能                   |
| 投稿詳細表示機能     | 各投稿詳細が詳細ページで閲覧可能             |
| ユーザー詳細表示機能 | 各ユーザーのレビューは閲覧可能               |
| コメント機能         | 投稿詳細ページからコメントが可能             |
| いいね機能           | 各投稿へいいねをつけることが可能             |


# 🔨 実装予定の機能

- ユーザー詳細機能にプロフィールを掲載する機能を実装予定


# 📎 データベース設計

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


## favorite テーブル

| Column     | Type      | Options                    |
| ---------- | --------- | -------------------------- |
| user       | reference | foreign_key: true          |
| book       | reference | foreign_key: true          |

### Association
- belongs_to :book
- belongs_to :user