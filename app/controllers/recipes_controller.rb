# frozen_string_literal: true

class RecipesController < ApplicationController
  include Paginable

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
end
