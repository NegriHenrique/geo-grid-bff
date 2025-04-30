Rails.application.routes.draw do
  get "/health", to: proc { [ 200, {}, [ "OK" ] ] }


  get "game/new", to: "game#new"

  get "countries", to: "countries#index"
  get "countries/ids", to: "countries#show_ids"


  resources :countries, only: [ :index ]
end
