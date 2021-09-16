Rails.application.routes.draw do
  resources :foods do
    resources :ingredients
  end

  post 'auth/login', to: 'authentication#authenticate'
end
