class AddImageAndCanBeFoundInColumnsToGemstone < ActiveRecord::Migration[7.1]
  def change
    add_column :gemstones, :image_url, :string
    add_column :gemstones, :can_be_found_in, :string, array: true, default: []
  end
end
