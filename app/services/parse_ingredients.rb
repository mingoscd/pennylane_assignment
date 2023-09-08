# frozen_string_literal: true

# This class is responsible for parsing ingredient strings into structured attributes.

class ParseIngredients
  QUANTITY_PATTERN = /(\d?\s?(?:¼|⅓|½|⅔|¾)?)\s?/
  UNIT_PATTERN = /(cup|tablespoon|teaspoon|package)s?\s?/

  # Parses a list of ingredients and returns an array of ingredient attribute hashes.
  #
  # @param ingredients [Array<String>] List of ingredient strings to be parsed.
  # @return [Array<Hash>] Array of ingredient attribute hashes.
  class << self
    def call(ingredients:)
      new.call(ingredients)
    end
  end

  # Parses a list of ingredients and returns an array of ingredient attribute hashes.
  #
  # @param ingredients [Array<String>] List of ingredient strings to be parsed.
  # @return [Array<Hash>] Array of ingredient attribute hashes.
  def call(ingredients)
    ingredients.map { |ingredient| parse_ingredient_attributes(ingredient) }
  end

  private

  # Parses an individual ingredient string, extracts attributes, and associates it with an ingredient in the database.
  #
  # @param ingredient [String] The ingredient string to be parsed.
  # @return [Hash] Hash containing ingredient attributes, including quantity, unit, name,
  #   description, and ingredient_id (associated ingredient's ID) if found.
  def parse_ingredient_attributes(ingredient)
    quantity_match = ingredient.match(QUANTITY_PATTERN)
    unit_match = ingredient.match(UNIT_PATTERN)
    name = ingredient.gsub(/#{quantity_match}|#{unit_match}/, "").gsub(",", "").strip

    ingredient_id = find_ingredient_id(name: name || ingredient)

    {
      quantity: quantity_match.to_s.strip,
      unit: (unit_match && unit_match[1]),
      name: name,
      description: ingredient,
      ingredient_id: ingredient_id,
    }
  end

  # Find ingredients by a case-insensitive, substring match of their names.
  #
  # @param name [String] The name or search query to find ingredients.
  # @return [Integer] Ingredient ID that match the search criteria.
  #
  # @example
  #   find_ingredient_id(name: "sugar")
  #   # Executes some basic search, the result can be improved with some NLP library
  #   # Returns all ingredients with names containing "sugar" or "sugars".
  #   # generated query: "SELECT ingredients.* FROM ingredients WHERE (name ILIKE '%sugar%' OR name ILIKE '%sugars%')"
  def find_ingredient_id(name:)
    search_terms = name.split.flat_map { |word| [word.singularize, word.pluralize].uniq }
    query = (["name ILIKE ?"] * search_terms.size).join(" OR ")
    values = search_terms.map { |term| "%#{term}%" }

    Ingredient.find_by(query, *values)&.id
  end
end
