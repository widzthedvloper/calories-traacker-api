Rails.application.routes.draw do
  resources :foods do
    resources :ingredients
  end
end
