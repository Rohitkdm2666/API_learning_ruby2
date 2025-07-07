Rails.application.routes.draw do
  resources :users

  post "/signup", to: "users#create"
  get "/getusers", to: "users#getAllUser"

  patch  "/update/:id", to: "users#update"
  put  "/update/:id", to: "users#update"
  delete "/delete/:id", to: "users#delete"
  
  get "up" => "rails/health#show", as: :rails_health_check

end
