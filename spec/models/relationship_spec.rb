require 'rails_helper'

RSpec.describe "Relationshipモデル", type: :model do
	describe "アソシエーションのテスト" do
		context "Userモデルとの関係" do
			it "N:1となっている(フォロー)" do
				expect(Relationship.reflect_on_association(:following).macro).to eq :belongs_to
			end
			it "N:1となっている(フォロワー)" do
				expect(Relationship.reflect_on_association(:follower).macro).to eq :belongs_to
			end
		end
	end
end
