class Category < ApplicationRecord
  # ■validation
  # 分類名称は、24文字以内。
  validates :name, presence: true, uniqueness: true, length: { maximum: 24 }

  # ■association
  # category:knowhow = 1:多。分類を削除する際、ノウハウは削除しない（コントローラに実装）。
  has_many :knowhows
end
