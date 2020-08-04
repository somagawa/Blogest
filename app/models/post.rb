class Post < ApplicationRecord

	validates :title, presence: true
	validates :body, presence: true
	validates :category_id, presence: true

	has_many :comments, dependent: :destroy
	has_many :likes, dependent: :destroy
	has_many :post_images, dependent: :destroy
	belongs_to :user
	belongs_to :category

	accepts_attachments_for :post_images, attachment: :image

	acts_as_taggable

	def liked_by?(user)
		likes.where(user_id: user.id).exists?
	end

  def self.ranking
    joins(:likes).group(:post_id).order('count(post_id) desc')
  end

	def self.search(keyword, address, category)
		if category == ""
			where(["title like? OR body like?", "%#{keyword}%", "%#{keyword}%"]).where("address like?", "%#{address}%")
		else
			where(category_id: category).where(["title like? OR body like?", "%#{keyword}%", "%#{keyword}%"]).where("address like?", "%#{address}%")
		end
	end
end
