class Client < ActiveRecord::Base
  attr_accessible :born_at, :full_legal_name, :contact_phone_number, :contact_email_address
  attr_accessible :residential_address_id, :mailing_address_id, :residential_address, :mailing_address

  has_many :aliases

  belongs_to :residential_address
  belongs_to :mailing_address
end
