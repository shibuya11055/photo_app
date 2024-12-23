class PhotosController < ApplicationController
  before_action :authenticate_user!

  def index
    @photos = current_user.photos
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
end

private

def photo_params
  params.require(:photo).permit(:title, :image)
end
