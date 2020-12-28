class RemoveBrandIdFromPosts < ActiveRecord::Migration[5.2]

  def change
    remove_column :posts, :brand_id, :integer
  end

end
