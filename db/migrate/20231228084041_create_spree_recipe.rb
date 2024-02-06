class CreateSpreeRecipe < ActiveRecord::Migration[6.1]
  def change
    create_table :spree_recipes do |t|
      t.string :name
      t.text :description
      t.timestamps
    end
  end
end
