# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :spouse do
    FactoryGirl::Common.person_attrs(self)

    #association :residential_address, factory: :residential_address, last_name: "Writely"
    association :mailing_address

    after(:create) do |spouse, evaluator|
      FactoryGirl.create_list(:alias, rand(5), client: spouse)
    end
  end
end
