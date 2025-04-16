class CreateAltSpellings < ActiveRecord::Migration[8.0]
  def change
    create_table :alt_spellings do |t|
      t.references :country, null: false, foreign_key: true
      t.string :value

      t.timestamps
    end
  end
end
