class CreateNames < ActiveRecord::Migration[5.0]
  def change
    create_table :names do |t|
      t.string :name
      t.integer :wiki_id
      t.integer :changed_to

      t.timestamps
      t.index :name, :unique => true
    end
  end
end
