Myflix::Application.routes.draw do
  
  get 'home', to: "videos#index"
  root to: "pages#front"
  #root to: "videos#index"
  
  resources :videos, only: [:index, :show] do 
    collection do
      get :search, to: "videos#search"
    end
    resources :reviews, only: [:create]
  end

  resources :categories, only: :show

  get 'register', to: "users#new"
  get 'sign_in', to: "sessions#new"
  delete 'sign_out', to: "sessions#destroy"

  resources :users, only: :create 
  resources :sessions, only: :create

  get 'my_queue', to: "queue_items#index"
  

  get 'ui(/:action)', controller: 'ui'

end
