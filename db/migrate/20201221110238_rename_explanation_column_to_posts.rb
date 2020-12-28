class RenameExplanationColumnToPosts < ActiveRecord::Migration[5.2]
  def change
    rename_column :posts , :explanation , :place_name
  end
end
