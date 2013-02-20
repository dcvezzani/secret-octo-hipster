class ResidentialAddress < Address
  # http://railsforum.com/viewtopic.php?id=36166
  # has_one :settlor_tenant, :class_name => "Settlor", :conditions => "type = 'Settlor'"
  # has_one :settlor, :through => :settlor_tenant, :source => :residential_address

  has_many :tenants, :class_name => "Client", :source => :residential_address
  has_one :settlor, :class_name => "Settlor"
  has_one :spouse, :class_name => "Spouse"
  has_many :children, :class_name => "Child", :source => :residential_address
end
