class Spouse < Client
  attr_accessible :settlor_id, :settlor, :marital_status, :us_citizen

  belongs_to :settlor
  has_many :children, foreign_key: :spouse_parent_id, dependent: :destroy
  has_many :joint_children, foreign_key: :settlor_parent_id
  has_many :personal_children, foreign_key: :settlor_parent_id
end
