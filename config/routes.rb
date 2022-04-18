Rails.application.routes.draw do
  get 'password_resets/new'
  get 'password_resets/edit'
  root 'static_pages#home'
  get'signup' => 'users#new'
  get'login'=>'sessions#new'
  post'login'=>'sessions#create'
  delete'logout'=>'sessions#destroy'
  resources :users
  resources :password_resets, only: [:new, :create, :edit, :update]
<<<<<<< HEAD
  resources :courses

  get 'learning' => 'words#show'
=======
  resources :courses do 
    member do 
      get :words
    end
  end
  get 'skill' => 'words#show'
>>>>>>> Words list course
end
