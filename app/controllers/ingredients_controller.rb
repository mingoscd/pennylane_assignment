# frozen_string_literal: true

class IngredientsController < ApplicationController
  def index
    @ingredients = Ingredient.search(params)

    respond_to do |format|
      format.turbo_stream
    end
  end
end
