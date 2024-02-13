class RenameSpreeRecipesIngredientsToSpreeRecipeIngredients < ActiveRecord::Migration[6.1]
  def change
    rename_table :spree_recipes_ingredients, :spree_recipe_ingredients
  end
end
