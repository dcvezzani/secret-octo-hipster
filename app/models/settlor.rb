class Settlor < Client
  attr_accessible :spouse, :marital_status, :us_citizen

  has_one :spouse, foreign_key: :settlor_id, dependent: :destroy
  has_many :children, foreign_key: :settlor_parent_id, dependent: :destroy
  has_many :joint_children, foreign_key: :settlor_parent_id
  has_many :personal_children, foreign_key: :settlor_parent_id


  attr_accessor :has_children
  attr_accessible :has_children

  def has_children?
    (self.children.length > 0)
  end
  def has_children
    return nil if self.new_record?
    self.has_children?
  end
end
