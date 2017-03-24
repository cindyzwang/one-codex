class CreateScientificNames < ActiveRecord::Migration[5.0]
  def change
    create_table :scientific_names do |t|
      t.string :name, null: false
      t.timestamps
    end
  end
end
