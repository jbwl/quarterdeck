Rails.application.routes.draw do
  mount Quarterdeck::Engine => "/analytics"
end
