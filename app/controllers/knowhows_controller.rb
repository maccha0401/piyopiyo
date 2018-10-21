class KnowhowsController < ApplicationController
  before_action :require_login, except: [:index, :show, :search]
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
    elsif (params[:knowhow][:index_type] == "search" unless params[:knowhow].nil?)
      set_search_params
      # and検索
      if params[:knowhow][:search_type] == "true"
        @command = "Knowhow.search(and: ["
        if params[:knowhow][:knowhow_class].blank?
          @command = @command + "{or: [{knowhow_class: true}, {knowhow_class: false}]}"
        else
          @command = @command + "{knowhow_class: params[:knowhow][:knowhow_class]}"
        end
        make_command_one("category_id")
        make_command_one("language_id")
        make_command_one("key_message")
        make_command_two("user_id", "create_user_id", "update_user_id")
        make_command_two("whole", "title", "content")
        @command = @command + "]).order(updated_at: :desc)"
      # or検索
      else
        # or検索、かつ検索アイテム入力なし
        if params[:knowhow][:category_id].blank? and params[:knowhow][:language_id].blank? and params[:knowhow][:key_message].blank? and params[:knowhow][:user_id].blank? and params[:knowhow][:whole].blank?
          @command = "Knowhow.search("
          if params[:knowhow][:knowhow_class].blank?
            @command = @command + "{or: [{knowhow_class: true}, {knowhow_class: false}]}"
          else
            @command = @command + "{knowhow_class: params[:knowhow][:knowhow_class]}"
          end
          @command = @command + ").order(updated_at: :desc)"
        # or検索、かつ検索アイテム入力あり
        else
          @command = "Knowhow.search("
          @command = @command + "{knowhow_class: params[:knowhow][:knowhow_class]}, {or: [" if !params[:knowhow][:knowhow_class].blank?
          @command = @command + "or: ["

          @command = "Knowhow.search(and: ["
          if params[:knowhow][:knowhow_class].blank?
            @command = @command + "{or: [{knowhow_class: true}, {knowhow_class: false}]}, {or: ["
          else
            @command = @command + "{knowhow_class: params[:knowhow][:knowhow_class]}, {or: ["
          end
          make_command_one("category_id")
          make_command_one("language_id")
          make_command_one("key_message")
          make_command_two("user_id", "create_user_id", "update_user_id")
          make_command_two("whole", "title", "content")
          @command = @command.sub!("{or: [, ", "{or: [") + "]}]).order(updated_at: :desc)"
        end
      end
      @knowhows = eval @command
      @page_title = "dictionary.title.search_result"

      if @knowhows.count.zero?
        flash.now[:notice] = t("dictionary.message.no_search_result")
      else
        flash.now[:notice] = t("dictionary.message.many_search_result", count: @knowhows.count)
      end
      # 一度、検索件数を算出するための処理
      @knowhows = @knowhows.page(params[:page])
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
    set_new_knowhow
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

  def search
    set_new_knowhow
  end

  private

  def knowhow_params
    params.require(:knowhow).permit(:knowhow_class, :category_id, :language_id,
                                    :title, :key_message, :content, :attachment,
                                    :attachment_cache, :remove_attachment)
  end

  def set_new_knowhow
    @knowhow = Knowhow.new
  end
  
  def set_knowhow
    @knowhow = Knowhow.find(params[:id])
  end

  def set_params_knowhow
    @knowhow = Knowhow.new(knowhow_params)
  end

  # 検索用
  def set_search_params
    params.require(:knowhow).permit(:index_type, :search_type, :knowhow_class,
                                    :category_id, :language_id, :key_message,
                                    :user_id, :whole)
  end

  def make_command_one(search_item)
    unless eval("params[:knowhow][:" + search_item + "].blank?")
      @command = @command + ", {" + search_item + ": params[:knowhow][:" + search_item + "]}"
    end
  end

  def make_command_two(search_item, search_target_one, search_target_two)
    unless eval("params[:knowhow][:" + search_item + "].blank?")
      @command = @command + ", {or: [{" + search_target_one + ": params[:knowhow][:" + search_item + "]}, {" + search_target_two + ": params[:knowhow][:" + search_item + "]}]}"
    end
  end
end
