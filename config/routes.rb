Rails.application.routes.draw do
  resources :wikis

  resources :charges, only: [:new, :create]

  devise_for :users

  get 'welcome/index'

  get 'welcome/about'

  root to:'welcome#index'

end
