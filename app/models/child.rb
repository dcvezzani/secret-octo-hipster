class Child < Client
  attr_accessible :alive, :has_special_needs, :settlor_parent, :settlor_parent_id, :spouse_parent, :spouse_parent_id
  
  belongs_to :settlor_parent, class_name: "Settlor"
  belongs_to :spouse_parent, class_name: "Spouse"
end
