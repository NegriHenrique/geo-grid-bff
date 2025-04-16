class CreateTranslations < ActiveRecord::Migration[8.0]
  def change
    create_table :translations do |t|
      t.references :country, null: false, foreign_key: true
      t.string :language_code
      t.string :official
      t.string :common

      t.timestamps
    end
  end
end
