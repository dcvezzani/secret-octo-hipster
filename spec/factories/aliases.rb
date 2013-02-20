# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :alias do
    value {[Faker::Name.first_name, Faker::Name.last_name].join(" ")}
  end
end
