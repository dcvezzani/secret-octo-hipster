class Alias < ActiveRecord::Base
  attr_accessible :id, :type, :value, :client_id, :client

  belongs_to :client
  belongs_to :settlor, class_name: "Settlor", foreign_key: :client_id
  belongs_to :spouse, class_name: "Spouse", foreign_key: :client_id
end
