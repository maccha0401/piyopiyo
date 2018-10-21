class CategoriesController < ApplicationController
  before_action :require_login
  before_action :require_admin
  before_action :set_params_category, only: [:create, :update]

  def index
    @categories = Category.all.order(name: :asc)
    @category = Category.first
    @new_category = Category.new
  end

  def create
    if @category.save
      flash.now[:notice] = t("dictionary.message.category_created")
    else
      flash.now[:notice] = t("dictionary.message.category_create_failed")
    end

    redirect_to categories_path
  end

  def update
    @category = Category.find(params[:id])
    if @category.update(category_params)
      flash.now[:notice] = t("dictionary.message.category_updated")
    else
      flash.now[:danger] = t("dictionary.message.category_update_failed")
    end

    redirect_to categories_path
  end

  def destroy
    # 指定された分類に属するノウハウが存在する場合、削除しない。
    if Knowhow.find_by(category_id: params[:id])
      flash.now[:danger] = t("dictionary.message.category_cannot_delete")
    else
      if Category.find(params[:id]).destroy
        flash.now[:notice] = t("dictionary.message.category_deleted")
      else
        flash.now[:danger] = t("dictionary.message.category_delete_failed")
      end
    end

    redirect_to categories_path
  end

  private

  def category_params
    params.require(:category).permit(:name)
  end

  def set_params_category
    @category = Category.new(category_params)
  end
end
