pin "@hotwired/stimulus", to: "stimulus.min.js"

# Chart.js is vendored into the engine (no CDN). The UMD build registers
# itself on `window.Chart` when imported as a module.
pin "chart.js/auto", to: "quarterdeck-csszero/vendor/chart.umd.min.js"

pin "quarterdeck-csszero/application", to: "quarterdeck-csszero/application.js"
pin "quarterdeck-csszero/controllers/chart_controller", to: "quarterdeck-csszero/controllers/chart_controller.js"
pin "quarterdeck-csszero/controllers/live_controller", to: "quarterdeck-csszero/controllers/live_controller.js"
pin "quarterdeck-csszero/controllers/menu_controller", to: "quarterdeck-csszero/controllers/menu_controller.js"
