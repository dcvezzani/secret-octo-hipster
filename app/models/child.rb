class Child < Client
  attr_accessible :alive, :has_special_needs
  
  belongs_to :settlor_parent, class_name: "Settlor", foreign_key: :client_id
  belongs_to :spouse_parent, class_name: "Spouse", foreign_key: :client_id
end
