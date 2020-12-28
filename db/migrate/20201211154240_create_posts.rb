class CreatePosts < ActiveRecord::Migration[5.2]
  def change
    create_table :posts do |t|
      t.string :item_name
      t.string :image_name
      t.integer :brand_id

      t.timestamps
    end
  end
end
