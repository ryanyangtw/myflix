Myflix::Application.routes.draw do
  
  get 'home', to: "videos#index"
  root to: "pages#front"
  #root to: "videos#index"
  
  resources :videos, only: [:index, :show] do 
    collection do
      get :search, to: "videos#search"
    end
  end

  resources :categories, only: :show

  get 'register', to: "users#new"
  get 'sign_in', to: "sessions#new"
  resources :users, only: :create 
  

  get 'ui(/:action)', controller: 'ui'

end
