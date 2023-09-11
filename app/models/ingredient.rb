# frozen_string_literal: true

class Ingredient < ApplicationRecord
  has_many :recipe_ingredients
  has_many :recipes, through: :recipe_ingredients

  scope :filter_by_name, ->(name) { where("name ILIKE ?", "%#{name}%") }

  class << self
    def search(params)
      params[:name].present? ? filter_by_name(params[:name]) : all
    end
  end
end
