# frozen_string_literal: true

class Recipe < ApplicationRecord
  SEARCHABLE_ATTRS = [:query]

  # Associations
  has_many :recipe_ingredients, dependent: :delete_all
  has_many :ingredients, through: :recipe_ingredients

  # Default scope to eager-load recipe ingredients.
  # RecipientIngredients are used in all the search, if not default_scope is not recommended
  default_scope { includes(:recipe_ingredients) }

  # Scopes
  scope :newest_by_ratings, -> { order(ratings: :desc, created_at: :desc) }
  scope :by_name, ->(query) { where("title ILIKE ?", "%#{query}%") }

  class << self
    # Search for recipes based on specified parameters
    #
    # @param [Hash] params - A hash of search parameters, valid keys on SEARCHABLE_ATTRS constant
    #   :query [String] - A search query for recipe titles
    #
    # @return [ActiveRecord::Relation] - A relation containing filtered and sorted recipes
    def search(params = {})
      filters = SEARCHABLE_ATTRS.filter { |attr| params[attr].present? }
      return newest_by_ratings if filters.empty?

      recipes = newest_by_ratings

      filters.each do |filter|
        case filter
        when :query then recipes = recipes.by_name(params[:query])
        end
      end

      recipes
    end
  end
end
