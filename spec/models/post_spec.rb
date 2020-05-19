require 'rails_helper'

RSpec.describe "Postモデル", type: :model do
	describe "バリデーションのテスト" do
		let(:user) { create(:user) }
		let(:post) { build(:post, user_id: user.id) }
		subject { post.valid? }

		context "titleカラム" do
			it "空欄でバリデートされる" do
				post.title = ""
				is_expected.to eq false
			end
		end
		context "bodyカラム" do
			it "空欄でバリデートされる" do
				post.body = ""
				is_expected.to eq false
			end
		end
	end

	describe "アソシエーションのテスト" do
		context "Userモデルとの関係" do
			it "N:1となっている" do
				expect(Post.reflect_on_association(:user).macro).to eq :belongs_to
			end
		end
		context "Commentモデルとの関係" do
			it "1:Nとなっている" do
				expect(Post.reflect_on_association(:comments).macro).to eq :has_many
			end
		end
		context "Likeモデルとの関係" do
			it "1:Nとなっている" do
				expect(Post.reflect_on_association(:likes).macro).to eq :has_many
			end
		end
	end
end
