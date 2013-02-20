# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :mailing_address do
    address_01 {Faker::Address.street_address}
    address_02 {Faker::Address.secondary_address}
    city {Faker::Address.city}
    state {Faker::Address.state_abbr}
    zip {Faker::Address.zip_code}
  end
end

