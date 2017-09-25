Rails.application.routes.draw do

  root 'listings#index'

  resources :passwords, controller: "clearance/passwords", only: [:create, :new]

  resources :listings, only: [:index] do
    resources :reservations, only: [:create, :show]
  end

  resources :users, controller: "users", only: [:edit, :update, :create, :show] do
    resource :password,
      controller: "clearance/passwords",
      only: [:create, :edit, :update]
    resources :listings
    resources :reservations, only: [:index] do
      member do
        get 'payment'
        post 'checkout'
      end
    end
  end

  get '/admin' => "admin#show", as: "admin"
  get '/admin/verify' => "admin#verify", as: "admin_verify"
  post '/admin/verify/:id' => "admin#confirm", as: "admin_confirm"
  
  post "/session" => "sessions#create"
  get "/auth/:provider/callback" => "sessions#create_from_omniauth"  
  get "/sign_in" => "clearance/sessions#new", as: "sign_in"
  delete "/sign_out" => "clearance/sessions#destroy", as: "sign_out"
  get "/sign_up" => "users#new", as: "sign_up"

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
