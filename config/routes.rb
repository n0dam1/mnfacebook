Rails.application.routes.draw do
  devise_for :users, controllers: {
    registrations: "users/registrations",
    omniauth_callbacks: "users/omniauth_callbacks"
  }
  resources :topics do
    resources :comments
  end

  resources :users, only: [:index, :show]

  resources :relationships, only: [:create, :destroy]

  resources :conversations do
    resources :messages
  end

  root 'topics#index'

  if Rails.env.development?
    mount LetterOpenerWeb::Engine, at: "/letter_opener"
  end
end
