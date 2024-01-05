FactoryBot.define do
  factory :user do
    name { Faker::Name.initials(number: 2) }
    last_name_cn          { '田中' }
    first_name_cn         { '太郎' }
    last_name_kana        { 'タナカ' }
    first_name_kana       { 'タロウ' }
    dob                   { Faker::Date.birthday }
    email                 { Faker::Internet.email }
    password              { '1a' + Faker::Internet.password(min_length: 6) }
    password_confirmation { password }
  end
end
