class Address < ActiveRecord::Base
  attr_accessible :address_01, :address_02, :city, :state, :type, :zip

  has_many :tenants, :class_name => "Client", :source => :residential_address
end
