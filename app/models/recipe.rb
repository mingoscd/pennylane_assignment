# frozen_string_literal: true

class Recipe < ApplicationRecord
  has_many :recipe_ingredients, dependent: :delete_all
  has_many :ingredients, through: :recipe_ingredients

  scope :newest_by_ratings, -> { order(ratings: :desc, created_at: :desc) }
end
