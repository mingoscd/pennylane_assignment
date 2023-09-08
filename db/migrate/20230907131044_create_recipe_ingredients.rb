class CreateRecipeIngredients < ActiveRecord::Migration[7.0]
  def change
    create_table :recipe_ingredients do |t|
      t.references :recipe, foreign_key: true
      t.references :ingredient, foreign_key: true, null: true
      t.string :quantity, null: true
      t.string :unit, null: true
      t.string :name, null: true
      t.string :description, null: false

      t.timestamps
    end
  end
end
