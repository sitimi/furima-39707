FactoryBot.define do
  factory :item do
    name                  { Faker::Name.initials(number: 2) }
    introduction          { Faker::Lorem.sentence }
    category_id              { '2' }
    condition_id             { '2' }
    delivery_charge_id       { '2' }
    region_id                { '2' }
    delivery_days_id         { '2' }
    price { Faker::Number.between(from: 300, to: 9_999_999) }
    association :user

    after(:build) do |item|
      item.image.attach(io: File.open('public/images/test_image.png'), filename: 'test_image.png')
    end
  end
end
