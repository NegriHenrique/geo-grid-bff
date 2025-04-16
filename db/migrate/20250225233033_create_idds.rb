class CreateIdds < ActiveRecord::Migration[8.0]
  def change
    create_table :idds do |t|
      t.references :country, null: false, foreign_key: true
      t.string :root
      t.json :suffixes

      t.timestamps
    end
  end
end
