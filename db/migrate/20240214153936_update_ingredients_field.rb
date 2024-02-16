class UpdateIngredientsField < ActiveRecord::Migration[6.1]
  def change
    remove_column :spree_ingredients, :variant_id, :bigint
    add_column :spree_ingredients, :product_id, :bigint
  end
end
