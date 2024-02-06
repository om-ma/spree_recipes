class CreateSpreeIngredients < ActiveRecord::Migration[6.1]
  def change
    create_table :spree_ingredients do |t|
      t.string :amount
      t.string :unit
      t.string :name
      t.text :note
      t.bigint :variant_id

      t.timestamps
    end
  end
end
