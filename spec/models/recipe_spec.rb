require 'rails_helper'

RSpec.describe Recipe, type: :model do
  let!(:recipe1) { create(:recipe, :with_ingredients) }
  let!(:recipe2) { create(:recipe, :with_ingredients) }
  let!(:recipe3) { create(:recipe, :with_ingredients) }

  describe 'search' do
    context 'when searching by title' do
      it 'returns recipes matching the search query' do
        results = Recipe.search(query: recipe1.title)
        expect(results).to include(recipe1)
        expect(results).not_to include(recipe2, recipe3)
      end

      it 'returns an empty result when no matching recipe is found' do
        results = Recipe.search(query: 'Burger')
        expect(results).to be_empty
      end
    end
  end

  describe '.by_ingredients' do
    let(:ingredient) { create(:ingredient) }
    let!(:recipe_ingredient1) { create(:recipe_ingredient, ingredient: ingredient) }
    let!(:recipe_ingredient2) { create(:recipe_ingredient, ingredient: ingredient) }

    before do
      recipe1.recipe_ingredients << recipe_ingredient1
      recipe2.recipe_ingredients << recipe_ingredient2
    end

    context 'when filtering by a single ingredient' do
      it 'returns recipes that contain the specified ingredient' do
        result = Recipe.by_ingredients([ingredient.id])
        expect(result).to include(recipe1, recipe2)
        expect(result).not_to include(recipe3)
      end
    end
  end
end