class CreateAliases < ActiveRecord::Migration
  def change
    create_table :aliases do |t|
      t.integer :id
      t.integer :client_id
      t.string :value
      t.string :type

      t.timestamps
    end
  end
end
