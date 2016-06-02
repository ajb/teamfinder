class CreateCheckins < ActiveRecord::Migration
  def change
    create_table :checkins do |t|
      t.references :location, index: true, foreign_key: true
      t.string :user

      t.timestamps null: false
    end
  end
end
