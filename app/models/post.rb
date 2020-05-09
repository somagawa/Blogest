class Post < ApplicationRecord

	validates :title, presence: true
	validates :body, presence: true

	has_many :comments, dependent: :destroy
	has_many :likes, dependent: :destroy
	belongs_to :user

	attachment :image

	def liked_by?(user)
		likes.where(user_id: user.id).exists?
	end
end
