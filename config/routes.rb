Rails.application.routes.draw do
  resources :friendships
  resources :headings
  resources :members
  root 'members#index'
end
