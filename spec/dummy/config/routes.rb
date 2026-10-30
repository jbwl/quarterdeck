Rails.application.routes.draw do
  mount Quarterdeck::CssZero::Engine => "/analytics"

  # Stands in for the host application's root, which the engine's header links
  # back to.
  root to: ->(_env) { [ 200, { "Content-Type" => "text/plain" }, [ "Dummy app" ] ] }
end
