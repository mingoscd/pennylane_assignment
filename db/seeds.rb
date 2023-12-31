# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).

ingredients_path = File.join(Rails.root, 'data', 'import', 'ingredients.json')
ingredients = JSON.parse(File.read(ingredients_path))

# insert all ingredients listed in the ingredients file. Silent if any error happens
Ingredient.insert_all(ingredients)


# INSERT RECIPES
# doing it here for simplicity. But its own rake task or a proper consumer like Kafka
# should be the proper approach to do this task in a real environment

# NOTE: If the recipe ingredient is not in the ingredients table, ingredient_id will be null

recipes_path = File.join(Rails.root, 'data', 'import', 'recipes.json')
recipes = JSON.parse(File.read(recipes_path))

# Split the recipes into batches to reduce memory usage
recipes.each_slice(100) do |recipe_batch|
  recipe_batch.each do |recipe|
    new_recipe = Recipe.create!(
      title: recipe['title'],
      cook_time: recipe['cook_time'],
      prep_time: recipe['prep_time'],
      ratings: recipe['ratings'],
      cuisine: recipe['cuisine'].downcase,
      category: recipe['category'].downcase,
      author: recipe['author'],
      image: recipe['image']
    )
    
    ingredients = ParseIngredients.call(ingredients: recipe['ingredients'])
                                  .map { |h| h.merge(recipe_id: new_recipe.id) }
    RecipeIngredient.insert_all(ingredients)
  end
end
