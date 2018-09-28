class Knowhow < ApplicationRecord
  # ■validation
  # knowhow_class は、default はfalse（ノウハウ）。
  validates :knowhow_class, presence: true, default: false, inclusion: { in: [true, false] }
  # category_id は、数字のみ許可、入力必須。なお、category テーブルの外部キー。
  validates :category_id, presence: true, numericality: { only_integer: true }
  # language_id は、数字のみ許可、入力を必須としない（言語以外のノウハウもある）。なお、language テーブルの外部キー。
  validates :language_id, numericality: { only_integer: true }
  # title は、24文字以内、独自性必須。
  validates :title, presence: true, uniqueness: true, length: { maximum: 24 }
  # key_message は、100文字以内、入力を必須としない。検索キーとして使用する。
  validates :key_message, length: { maximum: 100 }
  # content は、500文字以内、入力必須。テキスト形式。
  validates :content, presence: true, length: { maximum: 500 }
  # attachment は、72文字以内で添付ファイル名を格納する。なお、アップローダを指定する。
  validates :attachment, length: { maximum: 72 }
  # create_user_id は、数字のみ許可、新規作成時のみ入力必須。なお、user テーブルの外部キー。
  validates :create_user_id, presence: true, numericality: { only_integer: true }, on: :new
  # update_user_id は、数字のみ許可、更新時のみ入力必須。なお、user テーブルの外部キー。
  validates :update_user_id, presence: true, numericality: { only_integer: true }, on: :update
  # likes_count は、数字のみ許可、3桁、default は0。
  validates :likes_count, numericality: { only_integer: true, less_than: 1000 }, default: 0

  # ■association
  # category_id は、category テーブルの外部キー。
  belongs_to :category
  # language_id は、language テーブルの外部キー。
  belongs_to :language
  # create_user_id は、user テーブルの外部キー。
  belongs_to :create_user_id, :class_name => 'User', :foreign_key => 'create_user_id'
  # update_user_id は、user テーブルの外部キー。
  belongs_to :update_user_id, :class_name => 'User', :foreign_key => 'update_user_id'

  # ■Uploader
  # attachment にアップローダを指定。
  mount_uploader :picture, AttachmentUploader

  # ★★★後で修正！★★★
  # ■お気に入り
  # has_many :likes, dependent: :destroy
  # has_many :like_meganes, through: :likes, source: :megane
  # ★★★後で修正！★★★
end
