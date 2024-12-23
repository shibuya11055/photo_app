class SessionsController < ApplicationController
  def new
  end

  def create
    # 未入力チェック
    errors = []
    errors << 'ユーザーIDを入力してください' if params[:user_id].blank?
    errors << 'パスワードを入力してください' if params[:password].blank?

    if errors.any?
      p 'きてる？'
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
end
