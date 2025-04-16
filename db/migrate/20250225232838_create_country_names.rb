class CreateCountryNames < ActiveRecord::Migration[8.0]
  def change
    create_table :country_names do |t|
      t.references :country, null: false, foreign_key: true
      t.string :common
      t.string :official
      t.json :native_names

      t.timestamps
    end
  end
end
