# README

## 開発環境構築手順
1. ローカルにRuby、Rails、Postgresqlをインストール。
2. この[リポジトリ](https://github.com/shibuya11055/photo_app)を`git clone`する。
3. `bundle install`後、`rails db:setup` を実行。
4. `rails s`でサーバーを起動し、localhost:3000にアクセス。
5. ID: `user_001`、パスワード: `password001` でログイン（3を実行した際にアカウントが作成されます）。

## 環境変数
my_tweet_appと連携するために次の環境変数を定義する必要があります。  
（このアプリケーションでは[gem dotenv-rails](https://github.com/bkeepers/dotenv) を利用しており、`.env`ファイルに定義することで環境変数を利用できます。）
- MY_TWEET_APP_CLIENT_ID
  - OAuth連携に必要なclient_id
- MY_TWEET_APP_CLIENT_SECRET
  - OAuth連携に必要なclient_secret
- REDIRECT_URI
  - OAuth連携に必要なredirect_uri
- MY_TWEET_APP_POST_URL
  - my_tweet_appへツイートするためのURL
- HOST
  - ローカル環境の場合はlocalhost:3000を定義してください

## リンク

[DB設計](./docs/DB設計.md)

## Ruby version

3.3.6

## Rails version

8.0.1（動作確認済みのバージョン）
