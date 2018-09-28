class LanguagesController < ApplicationController
  before_action :require_login
  before_action :require_admin
  before_action :set_params_language, only: [:create, :update]

  def index
    @languages = Language.all.order(name: :asc)
    @language = Language.first
    @new_language = Language.new
  end

  def create
    if @language.save
      flash[:notice] = t("dictionary.message.language_created")
    else
      flash[:notice] = t("dictionary.message.language_create_failed")
    end
    redirect_to languages_path
  end

  def update
    @language = Language.find(params[:id])
    if @language.update(language_params)
      flash[:notice] = t("dictionary.message.language_updated")
    else
      flash[:danger] = t("dictionary.message.language_update_failed")
    end
    redirect_to languages_path
  end

  def destroy
# ★★★後で修正する。★★★
    if Language.find(params[:id]).destroy
      flash[:danger] = t("dictionary.message.language_deleted")
    else
      flash[:danger] = t("dictionary.message.language_delete_failed")
    end
    redirect_to languages_path
  end

  private

  def language_params
    params.require(:language).permit(:name)
  end

  def set_params_language
    @language = Language.new(language_params)
  end
end
