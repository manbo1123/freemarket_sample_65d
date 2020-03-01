# README

This README would normally document whatever steps are necessary to get the
application up and running.

Things you may want to cover:

* Ruby version

* System dependencies

* Configuration

* Database creation

* Database initialization

* How to run the test suite

* Services (job queues, cache servers, search engines, etc.)

* Deployment instructions

* ...


# summary
- フリマアプリのクローンサイト

# Functions
- ユーザー新規登録・ログイン/ログアウト機能・SNS連携
- 商品出品・購入
- カテゴリー・ブランド機能
- クレジットカード登録・支払い機能
- マイページ機能・編集
- 商品検索機能


# users table
|Column|Type|Options|
|------|----|-------|
|nickname|string|null:false|
|password|string|null:false|
|email|string|null:false, unique: true, index:true|

## Association
- has_many :comments, dependent: :destroy
- has_many :favorites, dependent: :destroy
- has_many :toDoLists
- has_many :userEvaluations
- has_many :seller_items, foreign_key: "seller_id", class_name: "items"
- has_many :buyer_items, foreign_key: "buyer_id", class_name: "items"
- has_one :point
- has_one :profile, dependent: :destroy
- has_one :snsAuthentication, dependent: :destroy
- has_one :sending_destination, dependent: :destroy
- has_one :creditCard, dependent: :destroy


# profiles table
|Column|Type|Options|
|------|----|-------|
|first_name|string|null:false|
|family_name|string|null:false|
|first_name_kana|string|null:false|
|family_name_kana|string|null:false|
|birthYear|date|null:false|
|birthMonth|date|null:false|
|birthDay|date|null:false|
|introduction|text||
|userImageUrl|string||
|user_id|references|null: false, foreign_key: true|

## Association
- belongs_to :user


# snsAuthentications table
|Column|Type|Options|
|------|----|-------|
|provider|string|null: false|
|uid|string|null: false, unique: true|
|token|text||
|user_id|references|null: false, foreign_key: true|

## Association
- belongs_to :user


# sending_destinations table
|Column|Type|Options|
|------|----|-------|
|destination_first_name|string|null: false|
|destination_family_name|string|null: false|
|destination_first_name_kana|string|null: false|
|destination_family_name_kana|string|null: false|
|postCode|integer(7)|null:false|
|prefecture_code|integer|null:false|
|city|string|null:false|
|houseNumber|string|null:false|
|buildingName|string||
|phoneNumber|integer| unique: true|
|user_id|references|null: false, foreign_key: true|

## Association
- belongs_to :user
- Gem：jp_prefectureを使用して都道府県コードを取得

# CreditCards table
|Column|Type|Options|
|------|----|-------|
|cardNunber|integer|null:false, unique: true|
|expirationYear|integer|null:false|
|expirationMonth|integer|null:false|
|securityCode|integer|null:false|
|user_id|references|null: false, foreign_key: true|

## Association
- belongs_to:user


# toDoLists table
|Column|Type|Options|
|------|----|-------|
|list|text|null:false|
|user_id|references|null: false, foreign_key: true|

## Association
- belongs_to:user


# points table
|Column|Type|Options|
|------|----|-------|
|point|integer||
|user_id|references|null: false, foreign_key: true|

## Association
- belongs_to:user

# userEvaluations table
|Column|Type|Options|
|------|----|-------|
|review|text|null: false|
|user_id|references|null: false, foreign_key: true|
|item_id|references|null: false, foreign_key: true|
|evaluation_id|references|null: false, foreign_key: true|

## Association
- belongs_to_active_hash :evaluation
- belongs_to :user
- belongs_to :item


# items table
|Column|Type|Options|
|------|----|-------|
|name|string|null: false|
|introduction|text|null: false|
|price|integer|null: false|
|brand_id|references|foreign_key: true|
|itemCondition_id|references|null: false,foreign_key: true|
|postagePayer_id|references|null: false,foreign_key: true|
|prefecture_code|integer|null: false|
|size_id|references|null: false, foreign_key: true|
|preparationDay_id|references|null: false, foreign_key: true|
|itemImg_id|references|null: false, foreign_key: true|
|category_id|references|null: false, foreign_key: true|
|tradingStatus|enum|null: false|
|selIer_id|references|null: false, foreign_key: true|
|buyer_id|references|foreign_key: true|
|dealClosedDate|timestamp||

## Association
- has_many :comments, dependent: :destroy
- has_many :favorites
- has_many :itemImgs, dependent: :destroy
- has_one :userEvaluation
- belongs_to :category
- belongs_to_active_hash :size
- belongs_to_active_hash :itemCondition
- belongs_to_active_hash :postagePayer
- belongs_to_active_hash :preparationDay
- belongs_to :brand
- belongs_to :seller, class_name: "User"
- belongs_to :buyer, class_name: "User"
- Gem：jp_prefectureを使用して都道府県コードを取得


# brands table
|Column|Type|Options|
|------|----|-------|
|name|string||

## Association
- has_many :items


# itemImgs table
|Column|Type|Options|
|------|----|-------|
|url|string|null:false|
|item_id|references|null: false, foreign_key: true|

## Association
- belongs_to :item


# favorites table
|Column|Type|Options|
|------|----|-------|
|user_id|references|null: false, foreign_key: true|
|item_id|references|null: false, foreign_key: true|

## Association
- belongs_to :user
- belongs_to :item

# comments table
|Column|Type|Options|
|------|----|-------|
|comment|text|null: false|
|user_id|references|null: false, foreign_key: true|
|item_id|references|null: false, foreign_key: true|
|created_at|timestamp|null: false|

## Association
- belongs_to :user
- belongs_to :item


# categories table
|Column|Type|Options|
|------|----|-------|
|name|string|null:false|
|ancestry|string||

## Association
- has_many :items