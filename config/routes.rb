Rails.application.routes.draw do
  root "recipes#landing"

  resources "recipes", only: [:index] do
    collection do
      post "search"
      get "check_ingredients"
    end
  end
end
