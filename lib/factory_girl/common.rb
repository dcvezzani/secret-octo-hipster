module FactoryGirl
module Common
  def self.person_attrs(decl)
    decl.instance_eval do
      full_legal_name {[Faker::Name.first_name, Faker::Name.last_name].join(" ")}
      born_at "2012-12-27 06:19:24"
      us_citizen {[true, false, false, false, false][rand(5)]}
      marital_status {%w{single married married}[rand(3)]}
      alive {[true, false, false, false, false][rand(5)]}
      has_special_needs {[true, false, false, false, false][rand(5)]}

      #association :residential_address, factory: :residential_address, last_name: "Writely"
      association :residential_address
    end
  end

  def self.address_attrs(decl)
    decl.instance_eval do
      address_01 {Faker::Address.street_address}
      address_02 {Faker::Address.secondary_address}
      city {Faker::Address.city}
      state {Faker::Address.state_abbr}
      zip {Faker::Address.zip_code}
    end
  end
end
end
