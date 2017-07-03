class CreateSightings < ActiveRecord::Migration[5.1]
  def change
    create_table :sightings do |t|
      t.string :weather
      t.string :habitat
      t.string :image_url
      t.date :date

      t.timestamps
    end
  end
end
