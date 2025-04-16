class CreateCountryMaps < ActiveRecord::Migration[8.0]
  def change
    create_table :country_maps do |t|
      t.references :country, null: false, foreign_key: true
      t.string :google_maps
      t.string :open_street_maps

      t.timestamps
    end
  end
end
