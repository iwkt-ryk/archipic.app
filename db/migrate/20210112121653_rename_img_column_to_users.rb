class RenameImgColumnToUsers < ActiveRecord::Migration[5.2]
  def change
    rename_column :users, :img , :image_name
  end
end
