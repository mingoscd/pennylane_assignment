FactoryBot.define do
  factory :recipe_ingredient do
    recipe { association(:recipe) }
    ingredient { association(:ingredient) }
    quantity { rand(1..5) }
    description { "test" }
  end
end