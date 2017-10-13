class ChangeColumnInRecipes < ActiveRecord::Migration[5.1]
  def change
    rename_column :recipes, :name, :email
    change_column :recipes, :email, :text
  end
end
