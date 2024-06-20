class CreateGemstones < ActiveRecord::Migration[7.1]
  def change
    create_table :gemstones do |t|
      t.string :name

      t.timestamps
    end
  end
end
