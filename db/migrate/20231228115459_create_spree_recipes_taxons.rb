class CreateSpreeRecipesTaxons < ActiveRecord::Migration[6.1]
  def change
    create_table :spree_recipes_taxons do |t|
      t.bigint :taxon_id
      t.bigint :recipe_id

      t.timestamps
    end
  end
end
