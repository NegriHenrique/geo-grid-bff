class CreateLanguages < ActiveRecord::Migration[8.0]
  def change
    create_table :languages do |t|
      t.references :country, null: false, foreign_key: true
      t.string :code
      t.string :name

      t.timestamps
    end
  end
end
