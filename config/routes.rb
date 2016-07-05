Rails.application.routes.draw do
  namespace :admin do
    resources :users, only: [:index, :show] do
      resources :user_roles, only: [:new, :create, :destroy]
    end

    namespace :charity, path: ':charity_slug' do
      resource :dashboard, only: [:show]
      resources :needs, only: [:index, :show, :edit, :update, :new, :create]
      resources :charities, only: [:edit, :update]
      resources :recipients do
        resources :need_items
      end
    end
  end

  namespace :charity,  path: ':charity', as: :charity do
    resources :recipients, only: :show
  end

  resources :users, only: [:new, :create, :edit, :update]

  resources :cart, only: [:index]

  resources :cart_items, only: [:create, :update, :destroy]

  get '/login', to: "sessions#new"
  post '/login', to: "sessions#create"
  delete '/logout', to: "sessions#destroy"

  get '/dashboard', to: "users#show"
  get 'admin/dashboard', to: "admin/dashboard#index"

  resources :donations, only: [:index, :show, :new, :create]

  resources :homes, only: [:show]

  root to: "homes#show"

  resources :charities, only: [:index, :new, :create]

  namespace :charity,  path: ':charity', as: :charity do
    resources :recipients, only: :show
  end

  get ':charity_slug', to: 'charities#show', as: :charity
  get 'causes/:causes_slug', to: 'causes#show', as: :cause
  get 'needs_category/:needs_category_slug', to: 'needs_categories#show', as: :needs_category

end
