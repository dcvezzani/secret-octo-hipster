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
      #association :residential_address

      after(:create) do |client, evaluator|
        srand()

        residence_addr_same_as_settlor = true#lambda{(rand(1000) < 800)}.call()
        residence_addr_same_as_settlor = (rand(1000) < 800)
        
        if(!residence_addr_same_as_settlor or client.is_a?(Settlor))
          client.update_attributes(residential_address: FactoryGirl.create(:residential_address))

        elsif(client.is_a?(Child))
          #debugger if(client.settlor_parent.nil?)
          if(client.settlor_parent or client.spouse_parent)
            residential_address = ((client.settlor_parent) ? client.settlor_parent : client.spouse_parent).residential_address
          else
            residential_address = FactoryGirl.create(:residential_address)
          end

          client.update_attributes(residential_address: residential_address)
          
        elsif(client.is_a?(Spouse))
          residential_address = ((client.settlor) ? client.settlor.residential_address : FactoryGirl.create(:residential_address))
          client.update_attributes(residential_address: residential_address)
        end

        mailing_addr_same_as_settlor = true#lambda{(rand(1000) < 800)}.call()
        mailing_addr_same_as_settlor = (rand(1000) < 800)
        
        if(!mailing_addr_same_as_settlor or client.is_a?(Settlor))
          client.update_attributes(mailing_address: FactoryGirl.create(:mailing_address))

        elsif(client.is_a?(Child))
          #debugger if(client.settlor_parent.nil?)
          if(client.settlor_parent or client.spouse_parent)
            mailing_address = ((client.settlor_parent) ? client.settlor_parent : client.spouse_parent).mailing_address
          else
            mailing_address = FactoryGirl.create(:mailing_address)
          end

          client.update_attributes(mailing_address: mailing_address)
          
        elsif(client.is_a?(Spouse))
          mailing_address = ((client.settlor) ? client.settlor.mailing_address : FactoryGirl.create(:mailing_address))
          client.update_attributes(mailing_address: mailing_address)
        end
        
      end
    end
  end

  def self.parent_attrs(decl)
    decl.instance_eval do
      contact_phone_number {Faker::PhoneNumber.phone_number}
      contact_email_address {Faker::Internet.email}

      association :mailing_address

      after(:create) do |client, evaluator|
        FactoryGirl.create_list(:alias, rand(3), client: client)

        has_children = [true, true, true, true, false][rand(5)]
        joint_children = [true, true, true, false, false][rand(5)]

        if(has_children)
          if(client.is_a?(Settlor))
            (0...rand(6)).each do
              child_type = [:personal_child, :joint_child, :joint_child][rand(2)]
              FactoryGirl.create(child_type, settlor_parent: client)
            end
            #FactoryGirl.create_list(:child, rand(6), settlor_parent: client)
            
          elsif(!joint_children and client.is_a?(Spouse))
            (0...rand(6)).each do
              #child_type = [:personal_child, :joint_child, :joint_child][rand(2)]
              FactoryGirl.create(:personal_child, spouse_parent: client)
            end
            #FactoryGirl.create_list(:child, rand(6), spouse_parent: client)
          end

        end
      end
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

=begin

puts Faker::PhoneNumber.singleton_methods(false)
phone_number
cell_phone

puts Faker::Internet.singleton_methods(false)
email
free_email
safe_email
user_name
domain_name
fix_umlauts
domain_word
domain_suffix
ip_v4_address
ip_v6_address
url

=end
