Rails.application.routes.draw do
  get 'rooms/index'
  get 'password_resets/new'
  get 'password_resets/edit'
  root 'static_pages#home'
  get 'signup' => 'users#new'
  get 'login' => 'sessions#new'
  post 'login' => 'sessions#create'
  delete 'logout' => 'sessions#destroy'
  resources :rooms do
    resources :messages
  end
  resources :users do
    get :chat
    member do
      get :following, :followers
    end
  end
  resources :relationships, only: %i[create destroy]
  resources :password_resets, only: %i[new create edit update]
  resources :courses do
    member do
      get :words
    end
  end
  resources :courses do
    resources :comments
  end

  resources :comments 
  resources :user_course
  resources :user_word
  get 'admin' => 'admin#index'
  namespace :admin do
    resources :users
    resources :courses
    resources :lessons
    resources :words do
      collection {post :import}
    end
    resources :questions
    resources :answers
  end
  resources :learning, controller: 'lessons', only: %i[index create] do
    collection do
      get 'practice'
    end
  end
  post 'practice' => 'practices#create'
  get 'get-correct-answer' => 'practices#correct_answers'
end
