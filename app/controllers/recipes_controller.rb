# frozen_string_literal: true

class RecipesController < ApplicationController
  include Paginable

  def landing
  end

  def index
    @recipes = infinite_scroll_pagination(
      Recipe.newest_by_ratings,
    )

    respond_to do |format|
      format.html
      format.turbo_stream
    end
  end

  def search
  end

  def check_ingredients
  end
end
