FactoryBot.define do
  factory :recipe do
    sequence(:title) { |i| "Recipe #{i}" }
    cook_time { 10 }
    prep_time { 10 }
    sequence(:ratings) { |i| 0.1 * i }

    trait :with_ingredients do
      after(:create) do |recipe, evaluator|
        recipe.recipe_ingredients << create_list(:recipe_ingredient, 2)
      end
    end
  end
end