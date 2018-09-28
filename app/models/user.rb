class User < ApplicationRecord
  # ■validation
  # login_id は、6文字の英数字のみ許可。
  validates :login_id, presence: true, uniqueness: true, length: { is: 6 }, format: { with: /\A[A-Za-z0-9]\w*\z/ }
  # user_name は、24文字以内、全角を許可。
  validates :user_name, presence: true, uniqueness: true, length: { maximum: 24 }
  # user_type は、default はfalse（一般ユーザ）。更新はtoggle メソッドのみ許可するため、validates は新規作成時のみ。
  validates :user_type, presence: true, default: false, inclusion: { in: [true, false] }, on: :new

  # ■password
  # password は、4～12文字の英数字のみ許可。
  has_secure_password
  validates :password, presence: true, length: { in: 4..12 }, format: { with: /\A[A-Za-z0-9]\w*\z/ }

  # ■association
  # user:knowhow = 1:多。ユーザの削除時、ノウハウは削除しない。
  has_many :knowhows

  # ★★★後で修正！★★★
  # ■お気に入り
  # has_many :likes, dependent: :destroy
  # has_many :like_meganes, through: :likes, source: :megane
  # ★★★後で修正！★★★
end
