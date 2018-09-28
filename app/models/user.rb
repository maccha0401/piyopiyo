class User < ApplicationRecord
  # ■validates
  # login_id は、6文字の英数字のみ許可。
  validates :login_id, presence: true, uniqueness: true, length: { is: 6 }, format: { with: /\A[A-Za-z0-9]\w*\z/ }
  # user_name は、24文字以内、全角を許可。
  validates :user_name, presence: true, uniqueness: true, length: { maximum: 24 }
  validates :user_type, presence: true, default: false, inclusion: { in: [true, false] }, on: :new

  # ■password
  # password は、4～12文字の英数字のみ許可。
  has_secure_password
  validates :password, presence: true, length: { in: 4..12 }, format: { with: /\A[A-Za-z0-9]\w*\z/ }

  # ★★★後で修正！★★★
  # ■association
  # has_many :meganes, dependent: :destroy
  # ★★★後で修正！★★★

  # ★★★後で修正！★★★
  # ■お気に入り
  # has_many :likes, dependent: :destroy
  # has_many :like_meganes, through: :likes, source: :megane
  # ★★★後で修正！★★★
end
