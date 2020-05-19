FactoryBot.define do
	factory :comment do
		body { Faker::Lorem.characters(number:100) }
	end
end