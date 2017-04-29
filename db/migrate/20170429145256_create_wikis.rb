class CreateWikis < ActiveRecord::Migration[5.0]
  def change
    create_table :wikis do |t|
      t.timestamps
    end
  end
end
