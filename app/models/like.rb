class Like < ApplicationRecord
  validates :user_id, presence: true
  validates :knowhow_id, presence: true
  belongs_to :user
  belongs_to :knowhow, counter_cache: :likes_count
end
