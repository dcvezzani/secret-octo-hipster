# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :client do
    id 1
    full_legal_name "MyString"
    born_at "2013-02-19 14:15:03"
    us_citizen false
    marital_status "MyString"
    alive false
    has_special_needs false
    created_at "2013-02-19 14:15:03"
    updated_at "2013-02-19 14:15:03"
    type ""
    children_status "MyString"
  end
end
