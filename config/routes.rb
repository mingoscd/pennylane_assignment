Rails.application.routes.draw do
  root "recipes#landing"

  resources "ingredients", only: [:index]
  resources "recipes", only: [:index] do
    get "check_ingredients", on: :collection
  end
end
