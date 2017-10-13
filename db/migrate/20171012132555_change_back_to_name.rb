class ChangeBackToName < ActiveRecord::Migration[5.1]
  def change
    rename_column :recipes, :email, :name
    change_column :recipes, :name, :string
  end
end
