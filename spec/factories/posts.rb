FactoryGirl.define do
  factory :post do
    title { Faker::Lorem.sentence }
		content { Faker::Lorem.sentence(10)}
		published true
  end
end
