class CreatePuzzles < ActiveRecord::Migration[7.1]
  def change
    create_table :puzzles do |t|
      t.string :question
      t.string :answer
      t.string :image

      t.timestamps
    end
  end
end
