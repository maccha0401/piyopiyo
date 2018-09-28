class Language < ApplicationRecord
  validates :name, presence: true, uniqueness: true, length: { maximum: 24 }
end
