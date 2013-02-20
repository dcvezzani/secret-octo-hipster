# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :residential_address do
    address_01 {Faker::Address.street_address}
    address_02 {Faker::Address.secondary_address}
    city {Faker::Address.city}
    state {Faker::Address.state_abbr}
    zip {Faker::Address.zip_code}
  end
end

=begin
puts Faker::Address.singleton_methods(false)
city
street_name
street_address
secondary_address
building_number
zip_code
zip
postcode
street_suffix
city_suffix
city_prefix
state_abbr
state
country
latitude
longitude
=end
