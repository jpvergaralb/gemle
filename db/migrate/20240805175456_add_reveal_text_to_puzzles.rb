class AddRevealTextToPuzzles < ActiveRecord::Migration[7.1]
  def change
    add_column :puzzles, :reveal_text, :string
  end
end
