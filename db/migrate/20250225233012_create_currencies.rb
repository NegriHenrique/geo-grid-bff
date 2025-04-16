class CreateCurrencies < ActiveRecord::Migration[8.0]
  def change
    create_table :currencies do |t|
      t.references :country, null: false, foreign_key: true
      t.string :code
      t.string :name
      t.string :symbol

      t.timestamps
    end
  end
end
