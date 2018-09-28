module UsersHelper
  # ユーザ種別に従って、admin or normal の印字方を返す関数
  def put_user_type(user)
    if user.user_type == true
      t "dictionary.item.admin"
    else
      t "dictionary.item.normal"
    end
  end
end
