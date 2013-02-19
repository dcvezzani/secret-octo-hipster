class Client < ActiveRecord::Base
  attr_accessible :alive, :born_at, :full_legal_name, :has_special_needs, :id, :marital_status, :type, :us_citizen, :contact_phone_number, :contact_email_address
  attr_accessible :spouse_id

  has_many :aliases

  has_one :residential_address
  has_one :mailing_address
end
