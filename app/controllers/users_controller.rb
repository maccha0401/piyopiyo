class UsersController < ApplicationController
  before_action :not_require_login, only: [:new, :create]
  before_action :require_login, except: [:new, :create]
  before_action :require_admin, only: [:index, :destroy, :chage_user_type, :admin_page]
  before_action :set_current_user, only: [:show, :edit, :update]
  before_action :set_params_user, only: [:create]

  def index
    @users = User.all.order(login_id: :asc)
  end

  def new
    @user = User.new
  end

  def create
    @user.user_type = false
    if @user.save
      session[:user_id] = @user.id
      flash[:notice] = t("dictionary.message.user_created")
      redirect_to :mypage
    else
      flash[:danger] = t("dictionary.message.user_create_failed")
      render new_users_path
    end
  end

  def update
    if @user.update(user_params)
      flash[:notice] = t("dictionary.message.user_updated")
      redirect_to :mypage
    else
      flash[:danger] = t("dictionary.message.user_update_failed")
      render edit_users_path
    end
  end

  def destroy
    if current_user.id == params[:id]
      flash[:danger] = t("dictionary.message.user_delete_failed")
    else
      if User.find(params[:id]).destroy
        flash[:notice] = t("dictionary.message.user_deleted")
      else
        flash[:danger] = t("dictionary.message.user_delete_failed")
      end
    end
    redirect_to users_index_path
  end

  def change_user_type
    if current_user.id == params[:id]
      flash[:danger] = t("dictionary.message.user_type_change_failed")
    else
      User.find(params[:id]).toggle!(:user_type)
      flash[:notice] = t("dictionary.message.user_type_changed")
    end
    redirect_to users_index_path
  end

  private

  def user_params
    params.require(:user).permit(:login_id, :user_name, :password, :password_confirmation)
  end

  def set_current_user
    @user = current_user
  end

  def set_params_user
    @user = User.new(user_params)
  end
end
