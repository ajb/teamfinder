class CreateLocations < ActiveRecord::Migration
  def change
    create_table :locations do |t|
      t.string :mac_address
      t.string :name

      t.timestamps null: false
    end
  end
end