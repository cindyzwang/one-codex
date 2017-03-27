class CreateNickNames < ActiveRecord::Migration[5.0]
  def change
    create_table :nick_names do |t|
      t.string :name
      t.integer :scientific_name_id, null: false
      t.timestamps
    end
  end
end
