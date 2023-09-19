# frozen_string_literal: true

class RecipeIngredient < ApplicationRecord
  belongs_to :recipe
  belongs_to :ingredient, optional: true

  default_scope { includes(:ingredient) }

  def highlighted_description
    return description if ingredient_id.nil?

    
    description.gsub(/#{Regexp.quote(ingredient.name)}/i, "<strong>#{ingredient.name}</strong>")
               .gsub(' <strong>', "&nbsp<strong>") # fix spaces before and after the tag
               .gsub('</strong> ', "</strong>&nbsp") 
               .html_safe
  end
end
