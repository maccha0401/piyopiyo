# ■ユーザの作成
def CreateUser(number)
  number = number.to_s
  User.create!(
    login_id: number,
    user_name: number,
    password: number,
    user_type: true
  )
end
CreateUser(999999)
CreateUser(222222)

# ■分類の作成
def CreateCategory(string)
  Category.create!(
    name: string
  )
end
CreateCategory("aiueo")
CreateCategory("kkkkk")
CreateCategory("oiuyt")

# ■言語の作成
def CreateLanguage(string)
  Language.create!(
    name: string
  )
end
CreateLanguage("C言語")
CreateLanguage("shell script")
