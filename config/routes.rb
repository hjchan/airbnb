Rails.application.routes.draw do

  root 'clearance/sessions#new'

  resources :passwords, controller: "clearance/passwords", only: [:create, :new]

  resources :listings

  resources :users, controller: "users", only: [:edit, :update, :create, :show] do
    resource :password,
      controller: "clearance/passwords",
      only: [:create, :edit, :update]
  end
  
  post "/session" => "sessions#create"
  get "/auth/:provider/callback" => "sessions#create_from_omniauth"  
  get "/sign_in" => "clearance/sessions#new", as: "sign_in"
  delete "/sign_out" => "clearance/sessions#destroy", as: "sign_out"
  get "/sign_up" => "users#new", as: "sign_up"

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
