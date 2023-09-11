require 'rails_helper'

RSpec.describe Recipe, type: :model do
  describe 'search' do
    let!(:recipe1) { Recipe.create(title: 'Spaghetti Carbonara', ratings: 4) }
    let!(:recipe2) { Recipe.create(title: 'Chicken Alfredo', ratings: 5) }
    let!(:recipe3) { Recipe.create(title: 'Margherita Pizza', ratings: 3) }

    context 'when searching by title' do
      it 'returns recipes matching the search query' do
        results = Recipe.search(query: 'Spaghetti')
        binding.pry
        expect(results).to include(recipe1)
        expect(results).not_to include(recipe2, recipe3)
      end

      it 'returns an empty result when no matching recipe is found' do
        results = Recipe.search(query: 'Burger')
        expect(results).to be_empty
      end
    end

    context 'when no search query is provided' do
      it 'returns recipes sorted by ratings and creation date' do
        results = Recipe.search
        expect(results).to eq([recipe2, recipe1, recipe3])
      end
    end
  end
end