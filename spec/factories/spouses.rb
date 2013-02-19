# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :spouse do
    id 1
    full_legal_name "MyString"
    born_at "2013-02-19 14:15:11"
    us_citizen false
    marital_status "MyString"
    alive false
    has_special_needs false
    created_at "2013-02-19 14:15:11"
    updated_at "2013-02-19 14:15:11"
    type ""
    children_status "MyString"
  end
end
