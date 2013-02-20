class Settlor < Client
  attr_accessible :spouse_id, :spouse, :marital_status, :us_citizen

  has_one :spouse
  has_many :children
end
