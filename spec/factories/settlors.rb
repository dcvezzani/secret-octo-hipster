# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :settlor do
    FactoryGirl::Common.person_attrs(self)
    FactoryGirl::Common.parent_attrs(self)

    #association :spouse 

    after(:create) do |settlor, evaluator|
      srand()

      FactoryGirl.create(:spouse, settlor_id: settlor.id) if(rand(6) < 5)
    end
  end
end
