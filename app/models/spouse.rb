class Spouse < Client
  attr_accessible :settlor_id, :settlor, :marital_status, :us_citizen

  has_one :settlor
  has_many :children
end
