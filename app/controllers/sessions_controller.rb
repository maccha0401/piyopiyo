class SessionsController < ApplicationController
  def new
    @user = User.new
  end

  def create
    # ログインIDでログイン
    @user = User.find_by(login_id: params[:session][:login_id])
    # ログインできた場合
    if @user && @user.authenticate(params[:session][:password])
      session[:user_id] = @user.id
      flash.now[:danger] = t("dictionary.message.login_succeeded")
      # 前のページがなければroot へ、あれば前のページへ。
      if session[:previous_url].nil?
        redirect_to :root
      else
        redirect_to session[:previous_url]
        session.delete(:previous_url)
      end
    # ログインできなかった場合、ログイン画面へ。
    else
      flash.now[:danger] = t("dictionary.message.login_failed")
      render "new"
    end
  end

  def destroy
    # ■ログアウト
    session.delete(:user_id)
    flash[:notice] = t("dictionary.message.logout_succeeded")
    redirect_to :root
  end
end
