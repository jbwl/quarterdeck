Matey::Engine.routes.draw do
  root to: "overview#show"
  resources :visits, only: [ :index, :show ]
  resources :events, only: [ :index ]
  resource :campaigns, only: [ :show ]
  resource :geographic, only: [ :show ]
end
