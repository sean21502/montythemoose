Rails.application.routes.draw do
  devise_for :models
  devise_for :users
  
  get 'welcome/index'

  get 'welcome/about'

  root to:'welcome#index'

  root to: 'home#index'

end
