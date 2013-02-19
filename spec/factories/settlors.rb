# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :settlor do
    id 1
    full_legal_name "MyString"
    born_at "2013-02-19 14:15:07"
    us_citizen false
    marital_status "MyString"
    alive false
    has_special_needs false
    created_at "2013-02-19 14:15:07"
    updated_at "2013-02-19 14:15:07"
    type ""
    children_status "MyString"
  end
end
