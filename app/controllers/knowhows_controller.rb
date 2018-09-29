class KnowhowsController < ApplicationController
  before_action :require_login, except: [:index, :show]
  before_action :require_admin, only: [:destroy]
  before_action :set_knowhow, only: [:show, :edit, :update, :destroy]
  before_action :set_params_knowhow, only: [:create]

  def index
    if params[:index_type] == "likes"
      @knowhows = current_user.like_knowhows
                    .order(updated_at: :desc).page(params[:page])
      @page_title = "dictionary.title.your_like_list"
    elsif params[:index_type] == "views"
      @knowhows = Knowhow.all.order(views_count: :desc)
                    .order(updated_at: :desc).page(params[:page])
      @page_title = "dictionary.title.ranking"
    else
      @knowhows = Knowhow.all.order(updated_at: :desc).page(params[:page])
      @page_title = "dictionary.title.knowhow_list"
    end
  end

  def show
    # 作成者or更新者でない場合、閲覧時にカウンターをアップする。
    if logged_in?
      if @knowhow.create_user_id != current_user.id && @knowhow.update_user_id != current_user.id
        @knowhow.increment!(:views_count, 1)
      end
    end
  end

  def new
    @knowhow = Knowhow.new
  end

  def create
    # 作成者は、current_user。
    @knowhow.create_user_id = current_user.id
    if @knowhow.save
      flash[:notice] = t("dictionary.message.knowhow_created")
      redirect_to knowhow_path(@knowhow.id)
    else
      flash[:danger] = t("dictionary.message.knowhow_create_failed")
      render new_knowhow_path
    end
  end

  def update
    # 作成者は、current_user。
    @knowhow.update_user_id = current_user.id
    if @knowhow.update(knowhow_params)
      flash[:notice] = t("dictionary.message.knowhow_updated")
      redirect_to knowhow_path(@knowhow.id)
    else
      flash[:danger] = t("dictionary.message.knowhow_update_failed")
      render edit_knowhows_path(@knowhow.id)
    end
  end

  def destroy
    if @knowhow.destroy
      flash[:notice] = t("dictionary.message.knowhow_deleted")
      redirect_to :root
    else
      flash[:danger] = t("dictionary.message.knowhow_delete_failed")
      render edit_knowhows_path(@knowhow.id)
    end
  end

  private

  def knowhow_params
    params.require(:knowhow).permit(:knowhow_class, :category_id, :language_id,
                                    :title, :key_message, :content, :attachment,
                                    :attachment_cache, :remove_attachment)
  end

  def set_knowhow
    @knowhow = Knowhow.find(params[:id])
  end

  def set_params_knowhow
    @knowhow = Knowhow.new(knowhow_params)
  end
end
