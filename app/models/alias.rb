class Alias < ActiveRecord::Base
  attr_accessible :id, :type, :value, :client_id, :client

  belongs_to :client
end
