class AddAncestryToScientificNames < ActiveRecord::Migration[5.0]
  def change
    add_column :scientific_names, :ancestry, :string
    add_index :scientific_names, :ancestry
  end
end
