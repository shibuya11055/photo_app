require 'net/http'
require 'uri'
require 'json'

class SessionsController < ApplicationController
  MY_TWEET_APP_CLIENT_ID = ENV['MY_TWEET_APP_CLIENT_ID']
  MY_TWEET_APP_CLIENT_SECRET = ENV['MY_TWEET_APP_CLIENT_SECRET']
  REDIRECT_URI = ENV['REDIRECT_URI']

  def new
  end

  def create
    # 未入力チェック
    errors = []
    errors << 'ユーザーIDを入力してください' if params[:user_id].blank?
    errors << 'パスワードを入力してください' if params[:password].blank?

    if errors.any?
      flash[:alert] = errors
      return render :new, status: :unprocessable_entity
    end

    user = User.find_by(login_id: params[:user_id])
    if user&.authenticate(params[:password])
      session[:user_id] = user.id
      flash[:notice] = 'ログインしました'
      redirect_to root_path
    else
      flash[:alert] = 'ログインID、またはパスワードが間違っています。'
      render :new, status: :unprocessable_entity
    end
  end

  def destroy
    session[:user_id] = nil
    flash[:notice] = 'ログアウトしました'
    redirect_to login_path
  end

  def my_tweet_app_oauth
    auth_url = 'http://unifa-recruit-my-tweet-app.ap-northeast-1.elasticbeanstalk.com/oauth/authorize?' +
    "response_type=code&" +
    "client_id=#{MY_TWEET_APP_CLIENT_ID}&" +
    "redirect_uri=#{REDIRECT_URI}&" +
    "scope=write_tweet"
    redirect_to(auth_url, allow_other_host: true)
  end

  def callback
    code = params[:code]
    uri = URI('http://unifa-recruit-my-tweet-app.ap-northeast-1.elasticbeanstalk.com/oauth/token')
    response = Net::HTTP.post_form(uri, {
      code: code,
      client_id: MY_TWEET_APP_CLIENT_ID,
      client_secret: MY_TWEET_APP_CLIENT_SECRET,
      redirect_uri: REDIRECT_URI,
      grant_type: 'authorization_code'
    })
    token_data = JSON.parse(response.body)
    access_token = token_data['access_token']
    # sessionに保持
    session[:access_token] = access_token

    redirect_to root_path, notice: 'MyTweetAppと連携しました'
  end
end
