class CreateSpreeRecipesInstructions < ActiveRecord::Migration[6.1]
  def change
    create_table :spree_recipes_instructions do |t|
      t.bigint :recipe_id
      t.bigint :instruction_id

      t.timestamps
    end
  end
end
