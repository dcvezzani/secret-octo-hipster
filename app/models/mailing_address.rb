class MailingAddress < Address
  has_many :recipients, :class_name => "Client", :source => :mailing_address
  has_one :settlor, :class_name => "Settlor"
  has_one :spouse, :class_name => "Spouse"
  has_many :children, :class_name => "Child", :source => :mailing_address
end
