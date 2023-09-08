class CreateIngredients < ActiveRecord::Migration[7.0]
  def change
    create_table :ingredients do |t|
      t.string :name, unique: true

      t.timestamps
    end

    add_index :ingredients, :name
  end
end
