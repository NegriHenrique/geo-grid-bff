class CreateCapitalInfos < ActiveRecord::Migration[8.0]
  def change
    create_table :capital_infos do |t|
      t.references :country, null: false, foreign_key: true
      t.float :lat
      t.float :lng

      t.timestamps
    end
  end
end
