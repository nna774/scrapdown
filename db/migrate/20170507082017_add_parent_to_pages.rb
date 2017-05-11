class AddParentToPages < ActiveRecord::Migration[5.0]
  def change
    add_column :pages, :parent, :integer
  end
end
