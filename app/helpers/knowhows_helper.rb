module KnowhowsHelper
  # 区分に従って、ノウハウ or 質問 の印字方を返す関数
  def put_knowhow_class(knowhow)
    if knowhow.knowhow_class == true
      t "dictionary.item.question"
    else
      t "dictionary.item.knowhow"
    end
  end

  # 言語の設定がない場合、設定なしと返す関数
  def put_knowhow_language_name(knowhow)
    if knowhow.language.nil?
      t "dictionary.message.none_language"
    else
      knowhow.language.name
    end
  end

  # ノウハウに関するユーザが削除されている場合、削除済と返す関数
  def put_knowhow_user_name(knowhow_user)
    if knowhow_user.present?
      knowhow_user.user_name
    else
      t "dictionary.message.none_user"
    end
  end

  # ノウハウの更新日時と作成日時が同じ場合、更新なしと返す関数
  def put_knowhow_updated_at(knowhow)
    if knowhow.updated_at == knowhow.created_at
      t "dictionary.message.none_update"
    else
      l(knowhow.updated_at, format: :default)
    end
  end

  # ノウハウの更新者を返す関数
  def put_knowhow_update_user_name(knowhow)
    # ノウハウの更新日時と作成日時が同じ場合、更新なしと返す。
    if knowhow.updated_at == knowhow.created_at
      t "dictionary.message.none_update"
    else
      # 更新者が削除されている場合、削除済と返す。
      put_knowhow_user_name(knowhow.update_user)
    end
  end

  # action に従って、new or edit を返す関数
  def new_or_edit_knowhow_path
    if controller.action_name == "new"
      knowhows_path
    elsif controller.action_name == "edit"
      knowhow_path(params[:id])
    end
  end

  # action に従って、new or edit のボタン名を返す関数
  def new_or_edit_button_knowhow_path
    if controller.action_name == "new"
      t "dictionary.button.create_knowhow"
    elsif controller.action_name == "edit"
      t "dictionary.button.update"
    end
  end
end
