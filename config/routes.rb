Rails.application.routes.draw do
  get "game/new", to: "game#new"

  resources :countries, only: [ :index ]
end
