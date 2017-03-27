class RenameParentId < ActiveRecord::Migration[5.0]
  def change
    rename_column :child_parents, :parent_id, :mother_id
  end
end
