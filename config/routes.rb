Rails.application.routes.draw do
  resources :wikis

  resources :charges, only: [:new, :create]

  devise_for :users

  get 'welcome/index'

  get 'welcome/about'

  post 'charges/downgrade' => 'charges#downgrade', :as => 'downgrade_user'

  root to:'welcome#index'

end
