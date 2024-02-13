class AddIngredientFieldToRecipe < ActiveRecord::Migration[6.1]
  def change
    add_column :spree_ingredients, :recipe_id, :bigint
    add_column :spree_ingredients, :position, :integer
    add_column :spree_ingredients, :external_link, :string
    add_column :spree_instructions, :recipe_id, :bigint
    add_column :spree_instructions, :position, :integer
  end
end
