class CreatePageNames < ActiveRecord::Migration[5.0]
  def change
    create_table :page_names do |t|
      t.integer :page_id
      t.integer :name_id

      t.timestamps
      t.index [:page_id, :name_id], :unique => true
    end
  end
end
