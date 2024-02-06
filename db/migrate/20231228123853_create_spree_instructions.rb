class CreateSpreeInstructions < ActiveRecord::Migration[6.1]
  def change
    create_table :spree_instructions do |t|
      t.text :description
      t.string :meta_data

      t.timestamps
    end
  end
end
