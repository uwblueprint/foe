class CreateSightings < ActiveRecord::Migration[5.1]
  def change
    create_table :sightings do |t|
      t.belongs_to :user, foreign_key: true
      t.string :weather
      t.string :habitat
      t.date :date

      t.timestamps
    end
  end
end
