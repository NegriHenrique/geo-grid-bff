class CreateCountries < ActiveRecord::Migration[8.0]
  def change
    create_table :countries do |t|
      t.string :cca2
      t.string :ccn3
      t.string :cca3
      t.boolean :independent
      t.string :status
      t.boolean :un_member
      t.string :region
      t.boolean :landlocked
      t.float :area
      t.integer :population
      t.string :start_of_week
      t.string :flag
      t.float :lat
      t.float :lng

      t.timestamps
    end
  end
end
