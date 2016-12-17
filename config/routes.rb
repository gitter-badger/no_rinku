Rails.application.routes.draw do

  root 'static_pages#home'
  get '/faq', to: 'static_pages#faq'

  devise_for :users, controllers: {
    omniauth_callbacks: "callbacks"
  }

  resources :bookmarks
  resources :users

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
