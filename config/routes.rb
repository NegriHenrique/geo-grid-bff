Rails.application.routes.draw do
  get "game/new", to: "game#new"

  get "countries", to: "countries#index"
  get "countries/ids", to: "countries#show_ids"

  get "/health", to: proc { [ 200, {}, [ "OK" ] ] }

  resources :countries, only: [ :index ]
end
