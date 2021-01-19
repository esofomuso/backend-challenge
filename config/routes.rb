Rails.application.routes.draw do
  resources :friendships
  resources :headings
  resources :members
  post 'members/:id/search', to: 'members#search', as: :search
  root 'members#index'
end
