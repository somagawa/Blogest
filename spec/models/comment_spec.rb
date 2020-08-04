require 'rails_helper'

RSpec.describe "Commentモデル", type: :model do
	describe "バリデーションのテスト" do
		let(:user) { create(:user) }
		let(:category) { create(:category)}
		let(:post) { create(:post, user_id: user.id, category_id: category.id)}
		let(:comment) { build(:comment, user_id: user.id, post_id: post.id) }
		subject { comment.valid? }

		context "bodyカラム" do
			it "空欄でバリデートされる" do
				comment.body = ""
				is_expected.to eq false
			end
		end
	end

	describe "アソシエーションのテスト" do
		context "Userモデルとの関係" do
			it "N:1となっている" do
				expect(Comment.reflect_on_association(:user).macro).to eq :belongs_to
			end
		end
		context "Postモデルとの関係" do
			it "N:1となっている" do
				expect(Comment.reflect_on_association(:post).macro).to eq :belongs_to
			end
		end
	end
end
