# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :child do
    id 1
    full_legal_name "MyString"
    born_at "2013-02-19 16:19:03"
    alive false
    has_special_needs false
    type ""
  end
end
