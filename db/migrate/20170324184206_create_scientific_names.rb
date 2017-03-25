class CreateScientificNames < ActiveRecord::Migration[5.0]
  def change
    create_table :scientific_names, {id: false} do |t|
      t.integer :taxonomy_id, null: false
      t.string :name, null: false
      t.timestamps
    end

    execute "ALTER TABLE scientific_names ADD PRIMARY KEY (taxonomy_id);"
  end
end
