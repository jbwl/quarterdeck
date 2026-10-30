Rails.application.routes.draw do
  mount Quarterdeck::CssZero::Engine => "/analytics"
end
