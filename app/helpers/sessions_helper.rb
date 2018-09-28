module SessionsHelper
  # ■現在のログインユーザを取得する関数
  def current_user
    @current_user ||= User.find_by(id: session[:user_id])
  end

  # ■ログイン済である場合、trueを返す関数
  def logged_in?
    current_user.present?
  end
  
  # ■管理者ユーザである場合、trueを返す関数
  def admin?
    current_user.user_type
  end

  # ■ログインしていない場合、ログイン画面に移行する関数
  def require_login
    if !logged_in?
      session[:previous_url] = request.fullpath
      redirect_to users_login_path
    end
  end

  # ■ログインしている場合、root に移行する関数
  def not_require_login
    redirect_to :root if logged_in?
  end

  # ■管理者ユーザでない場合、ログイン画面に移行する関数
  def require_admin
    redirect_to :root if !admin?
  end
end
