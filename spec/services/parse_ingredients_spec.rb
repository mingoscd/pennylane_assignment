require 'rails_helper'

RSpec.describe ParseIngredients do
  before do
    Ingredient.create!(name: 'sugar')
  end

  describe '.call' do
    it 'parses a list of ingredients' do
      ingredients = [
        '1 cup flour',
        '2 teaspoons sugar',
        '3 eggs, beaten',
      ]

      parsed_ingredients = ParseIngredients.call(ingredients: ingredients)

      expect(parsed_ingredients.length).to eq(3)

      expect(parsed_ingredients[0]).to include(
        quantity: '1',
        unit: 'cup',
        name: 'flour',
        description: '1 cup flour',
        ingredient_id: nil
      )

      expect(parsed_ingredients[1]).to include(
        quantity: '2',
        unit: 'teaspoon',
        name: 'sugar',
        description: '2 teaspoons sugar',
        ingredient_id: kind_of(Integer)
      )

      expect(parsed_ingredients[2]).to include(
        quantity: '3',
        unit: nil,
        name: 'eggs beaten',
        description: '3 eggs, beaten',
        ingredient_id: nil
      )
    end
  end
end
