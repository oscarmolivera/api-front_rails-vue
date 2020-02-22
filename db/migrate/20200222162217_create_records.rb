class CreateRecords < ActiveRecord::Migration[6.0]
  def change
    create_table :records do |t|
      t.string :tittle
      t.string :year
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
  end
end
