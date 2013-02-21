class Settlor < Client
  attr_accessible :spouse, :marital_status, :us_citizen

  has_one :spouse, foreign_key: :settlor_id, dependent: :destroy
  has_many :children, foreign_key: :settlor_parent_id, dependent: :destroy
  has_many :joint_children, foreign_key: :settlor_parent_id
  has_many :personal_children, foreign_key: :settlor_parent_id
end
