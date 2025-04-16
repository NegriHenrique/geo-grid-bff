class CreateCars < ActiveRecord::Migration[8.0]
  def change
    create_table :cars do |t|
      t.references :country, null: false, foreign_key: true
      t.string :side
      t.json :signs

      t.timestamps
    end
  end
end
