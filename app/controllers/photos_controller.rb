class PhotosController < ApplicationController
  before_action :authenticate_user!

  def index
    @photos = current_user.photos
    @has_access_token = session[:access_token].present?
  end

  def new
    @photo = Photo.new
  end

  def create
    @photo = Photo.new(photo_params)
    @photo.user_id = current_user.id

    if @photo.save
      flash[:notice] = '写真がアップロードされました'
      redirect_to photos_path
    else
      render :new, status: :unprocessable_entity
    end
  end

  def my_tweet_app_post
    access_token = session[:access_token]

    if access_token.blank?
      flash[:alert] = 'アクセストークンがありません'
      redirect_to root_path
      return
    end

    photo = current_user.photos.find(params[:id])
    response = ::MyTweetAppPostService.call(photo.title, image_url(photo), access_token, ENV['MY_TWEET_APP_POST_URL'])

    if response.code.to_i == 201
      flash[:notice] = "ツイートに成功しました"
    else
      flash[:alert] = "ツイートに失敗しました"
    end

    redirect_to root_path
  end
end

private

def photo_params
  params.require(:photo).permit(:title, :image)
end

def image_url(photo)
  Rails.application.routes.url_helpers.rails_blob_url(photo.image, host: ENV['HOST'])
end
