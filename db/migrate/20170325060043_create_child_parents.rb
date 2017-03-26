class CreateChildParents < ActiveRecord::Migration[5.0]
  def change
    create_table :child_parents, {id: false} do |t|
      t.integer :child_id, null: false
      t.integer :parent_id, null: false
      t.string :rank, null: false
      t.timestamps
    end

    execute "ALTER TABLE child_parents ADD PRIMARY KEY (child_id);"
  end
end
