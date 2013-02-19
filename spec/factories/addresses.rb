# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :address do
    address_01 "MyString"
    address_02 "MyString"
    city "MyString"
    state "MyString"
    zip "MyString"
    type ""
  end
end
