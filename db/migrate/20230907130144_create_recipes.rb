class CreateRecipes < ActiveRecord::Migration[7.0]
  def change
    create_table :recipes do |t|
      t.string :title
      t.integer :cook_time
      t.integer :prep_time
      t.decimal :ratings, precision: 3, scale: 2
      t.string :cuisine
      t.string :category
      t.string :author
      t.text :image

      t.timestamps
    end

    add_index :recipes, :category
    add_index :recipes, :cuisine
    add_index :recipes, :ratings
  end
end
