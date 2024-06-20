class CreateGames < ActiveRecord::Migration[7.1]
  def change
    create_table :games do |t|
      t.references :gemstone, null: false, foreign_key: true
      t.integer :game_number
      t.string :game_type
      t.date :date

      t.timestamps
    end
  end
end
