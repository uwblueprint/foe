class AddStreetAddressToSighting < ActiveRecord::Migration[5.2]
  def change
    add_column :sightings, :street_address, :string
  end
end
