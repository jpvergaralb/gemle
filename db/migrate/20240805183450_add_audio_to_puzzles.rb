class AddAudioToPuzzles < ActiveRecord::Migration[7.1]
  def change
    add_column :puzzles, :audio, :string
  end
end
