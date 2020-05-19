FactoryBot.define do
	factory :post do
		title { Faker::Lorem.characters(number:15) }
		body { Faker::Lorem.characters(number:400) }
		post_code { Faker::Address.zip_code }
		address { "東京都千代田区1-1-1" }
	end
end