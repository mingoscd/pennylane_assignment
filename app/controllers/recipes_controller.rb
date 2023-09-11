# frozen_string_literal: true

class RecipesController < ApplicationController
  include Paginable

  before_action :set_ingredients, only: :check_ingredients

  def landing
  end

  def index
    @recipes = infinite_scroll_pagination(
      Recipe.search(params),
    )

    respond_to do |format|
      format.html
      format.turbo_stream
    end
  end

  def check_ingredients
  end

  private

  def set_ingredients
    @ingredients = Ingredient.all
  end
end
