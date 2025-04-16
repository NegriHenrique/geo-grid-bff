class CreateCapitals < ActiveRecord::Migration[8.0]
  def change
    create_table :capitals do |t|
      t.references :country, null: false, foreign_key: true
      t.string :name

      t.timestamps
    end
  end
end
