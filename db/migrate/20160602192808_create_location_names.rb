class CreateLocationNames < ActiveRecord::Migration
  class Location < ActiveRecord::Base
  end

  class LocationName < ActiveRecord::Base
  end

  def change
    create_table :location_names do |t|
      t.references :location, index: true, foreign_key: true
      t.string :name

      t.timestamps null: false
    end

    Location.find_each do |location|
      if location.name.present?
        LocationName.create(location_id: location.id, name: location.name)
      end
    end

    remove_column :locations, :name
  end
end
