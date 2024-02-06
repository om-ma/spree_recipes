class AddSlugToRecipe < ActiveRecord::Migration[6.1]
  def change
    add_column :spree_recipes, :slug, :string
    add_index :spree_recipes, :slug, unique: true
  end
end
