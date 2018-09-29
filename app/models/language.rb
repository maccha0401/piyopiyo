class Language < ApplicationRecord
  # ■validation
  # 言語名称は、24文字以内。
  validates :name, presence: true, uniqueness: true, length: { maximum: 24 }

  # ■association
  # language:knowhow = 1:多。言語削除時、ノウハウは削除しない（コントローラに実装）。
  has_many :knowhows
end
