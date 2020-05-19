require 'rails_helper'

RSpec.describe "Userモデル", type: :model do
	describe "バリデーションのテスト" do
		let(:user) { build(:user) }
		subject { user.valid? }

		context "nameカラム" do
			it "空欄でバリデートされる" do
				user.name = ""
				is_expected.to eq false
			end
		end

		context "emailカラム" do
			it "空欄でバリデートされる" do
				user.email = ""
				is_expected.to eq false
			end
		end
	end

	describe "アソシエーションのテスト" do
		context "Postモデルとの関係" do
			it "1:Nとなっている" do
				expect(User.reflect_on_association(:posts).macro).to eq :has_many
			end
		end
		context "Commentモデルとの関係" do
			it "1:Nとなっている" do
				expect(User.reflect_on_association(:comments).macro).to eq :has_many
			end
		end
		context "Likeモデルとの関係" do
			it "1:Nとなっている" do
				expect(User.reflect_on_association(:likes).macro).to eq :has_many
			end
		end
		context "Relationshipモデルとの関係" do
			it "1:Nとなっている(フォロー)" do
				expect(User.reflect_on_association(:active_relationships).macro).to eq :has_many
			end
			it "1:Nとなっている(フォロワー)" do
				expect(User.reflect_on_association(:passive_relationships).macro).to eq :has_many
			end
		end
	end
end
