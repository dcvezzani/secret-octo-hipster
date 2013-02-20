class CreateClients < ActiveRecord::Migration
  def change
    create_table :clients do |t|
      t.integer :id
      t.string :full_legal_name
      t.datetime :born_at
      t.boolean :us_citizen
      t.string :marital_status
      t.boolean :alive
      t.boolean :has_special_needs
      t.string :type
      t.string :contact_phone_number
      t.string :contact_email_address
      t.integer :settlor_id
      t.integer :settlor_parent_id
      t.integer :spouse_parent_id
      t.integer :residential_address_id
      t.integer :mailing_address_id

      t.timestamps
    end
  end
end
