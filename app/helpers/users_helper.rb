module UsersHelper
  # ユーザ種別に従って、admin or normal の印字方を返す関数
  def put_user_type(user)
    user.user_type ? t("dictionary.item.admin") : t("dictionary.item.normal")
  end
end
