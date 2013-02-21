class Client < ActiveRecord::Base
  attr_accessible :born_at, :full_legal_name, :contact_phone_number, :contact_email_address
  attr_accessible :residential_address_id, :mailing_address_id, :residential_address, :mailing_address

  has_many :aliases, dependent: :destroy

  belongs_to :residential_address
  belongs_to :mailing_address

  after_destroy :remove_orphaned_residential_addresses, :remove_orphaned_mailing_addresses

  private 

  def remove_orphaned_residential_addresses
    Rails.logger.debug("removing orphaned residential addresses...")
    xtenants = ResidentialAddress.joins{tenants}
    xorphaned_tenants = ResidentialAddress.where{id.not_in(xtenants.select{id})}
    ResidentialAddress.destroy_all(["id in (?)", xorphaned_tenants.select{id}.map(&:id)])
  end

  def remove_orphaned_mailing_addresses
    Rails.logger.debug("removing orphaned mailing addresses...")
    xrecipients = MailingAddress.joins{recipients}
    xorphaned_recipients = MailingAddress.where{id.not_in(xrecipients.select{id})}
    MailingAddress.destroy_all(["id in (?)", xorphaned_recipients.select{id}.map(&:id)])
  end
end
