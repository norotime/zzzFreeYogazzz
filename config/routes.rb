Rails.application.routes.draw do
  
  get 'managers/index'

  get 'managers/show'
  
  get 'sessions/new'

  mount RailsAdmin::Engine => '/admin', as: 'rails_admin'
  
  devise_for :managers
  devise_scope :managers do
    post  "sessions/manager", to: 'devise/sessions#create'
  end

  resources :contacts do
    collection do
      post :confirm
    end  
  end  
  
  root to: 'events#index'
  resources :events do
    collection do 
      post :confirm
    end
    
    member do
      post :confirm
    end
  end
    
    resources :feeds
    resources :sessions, only: [:new, :create, :destroy]
    resources :users
    resources :managers do 
       collection do 
         
         post :allow
         post :back
       end
    end  
    
   
    
    if Rails.env.development?
      mount LetterOpenerWeb::Engine, at: "/inbox"
    end
end
