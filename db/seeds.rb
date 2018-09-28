# def CreateUser(number)
#   number = number.to_s
#   User.create!(
#     login_id: number,
#     user_name: number,
#     password: number,
#     user_type: true
#   )
# end
# # ■ユーザの作成
# CreateUser(999999)

# def CreateCategory(string)
#   Category.create!(
#     name: string
#   )
# end
# # ■分類の作成
# CreateCategory("aiueo")
# CreateCategory("kkkkk")
# CreateCategory("oiuyt")

def CreateLanguage(string)
  Language.create!(
    name: string
  )
end
# ■言語の作成
CreateLanguage("123456")
CreateLanguage("987654")
