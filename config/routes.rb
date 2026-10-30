Quarterdeck::CssZero::Engine.routes.draw do
  root to: "overview#show"
  resources :visits, only: [ :index, :show ]
  resources :events, only: [ :index ]
  resource :top_events, only: [ :show ]
  resource :campaigns, only: [ :show ]
  resource :geographic, only: [ :show ]
  resource :live, only: [ :show ], controller: "live"
end
