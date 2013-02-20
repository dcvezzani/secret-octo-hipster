class CreateAddresses < ActiveRecord::Migration
  def self.up
    create_table :addresses do |t|
      t.string :address_01
      t.string :address_02
      t.string :city
      t.string :state
      t.string :zip
      t.string :type

      t.timestamps
    end

    # create_table :clients_addresses do |t|
    #   t.integer :client_id
    #   t.integer :address_id

    #   t.timestamps
    # end
  end
  def self.down
    #drop_table :clients_addresses
    drop_table :addresses
  end
end
