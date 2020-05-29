class Post < ApplicationRecord

	validates :title, presence: true
	validates :body, presence: true

	has_many :comments, dependent: :destroy
	has_many :likes, dependent: :destroy
	belongs_to :user

	attachment :image

	acts_as_taggable

	def liked_by?(user)
		likes.where(user_id: user.id).exists?
	end

	def self.search(keyword, address)
		where(["title like? OR body like?", "%#{keyword}%", "%#{keyword}%"]).where("address like?", "%#{address}%")
	end
end
