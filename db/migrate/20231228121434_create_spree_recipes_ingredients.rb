class CreateSpreeRecipesIngredients < ActiveRecord::Migration[6.1]
  def change
    create_table :spree_recipes_ingredients do |t|
      t.bigint :recipe_id
      t.bigint :ingredient_id

      t.timestamps
    end
  end
end
