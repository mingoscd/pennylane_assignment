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
    if params[:ingredient_ids]&.any?
      @recipes = infinite_scroll_pagination(
        Recipe.by_ingredients(params[:ingredient_ids]),
      )
    end

    respond_to do |format|
      format.html
      format.turbo_stream
    end
  end

  private

  def set_ingredients
    @ingredients = Ingredient.all
  end
end
