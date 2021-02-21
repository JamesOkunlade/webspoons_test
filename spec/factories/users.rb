FactoryBot.define do
    factory :user do
      name { Faker::Name.name }
      email { Faker::Internet.email }
      title { Faker::Job.title }
      phone { Faker::PhoneNumber.phone_number_with_country_code }
      status { ['active', 'inactive'].sample }
    end
end