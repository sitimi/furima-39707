FactoryBot.define do
  factory :item do
    name                  {Faker::Name.initials(number: 2)}
    introduction          {Faker::Lorem.sentence}
    category_id              {'2'}
    condition_id             {'2'}
    delivery_charge_id       {'2'}
    region_id                {'2'}
    delivery_days_id         {'2'}
    price                 {Faker::Number.between(from: 300, to: 9999999)}
    association :user
  end
end
