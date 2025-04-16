class CreateCoatOfArms < ActiveRecord::Migration[8.0]
  def change
    create_table :coat_of_arms do |t|
      t.references :country, null: false, foreign_key: true
      t.string :png
      t.string :svg

      t.timestamps
    end
  end
end
