class AddLocationToSighting < ActiveRecord::Migration[5.2]
  def change
    change_table :sightings do |t|
      t.string :species
      t.float :latitude, null: false
      t.float :longitude, null: false
    end
  end
end
