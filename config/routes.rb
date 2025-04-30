Rails.application.routes.draw do
  get "up" => "rails/health#show", as: :rails_health_check


  get "game/new", to: "game#new"

  get "countries", to: "countries#index"
  get "countries/ids", to: "countries#show_ids"


  resources :countries, only: [ :index ]
end
