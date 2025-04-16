class CreateDemonyms < ActiveRecord::Migration[8.0]
  def change
    create_table :demonyms do |t|
      t.references :country, null: false, foreign_key: true
      t.string :language_code
      t.string :female
      t.string :male

      t.timestamps
    end
  end
end
