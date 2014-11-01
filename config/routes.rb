Rails.application.routes.draw do
  root to: 'home#index'
  devise_for :trainers
  resources :trainers
  resources :pokemons
  patch '/capture', to: 'pokemons#capture'
  patch '/damage', to: 'pokemons#damage'
end
