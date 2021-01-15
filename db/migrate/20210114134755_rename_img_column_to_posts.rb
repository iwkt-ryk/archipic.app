class RenameImgColumnToPosts < ActiveRecord::Migration[5.2]
  def change
    rename_column :posts , :img , :image_name
  end
end
