FactoryBot.define do

	Faker::Config.locale = :ja

	factory :user do
		name { Faker::Lorem.characters(number:10) }
		email { Faker::Internet.email }
		password { Faker::Lorem.characters(number:10) }
	end
end