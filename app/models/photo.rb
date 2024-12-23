class Photo < ApplicationRecord
  has_one_attached :image

  belongs_to :user

  validates :title, presence: true, length: { maximum: 30 }
  validates :image, presence: { message: 'を選択してください' }
end
