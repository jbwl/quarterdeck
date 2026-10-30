pin "@hotwired/stimulus", to: "stimulus.min.js"

# Chart.js is vendored into the engine (no CDN). The UMD build registers
# itself on `window.Chart` when imported as a module.
pin "chart.js/auto", to: "quarterdeck/vendor/chart.umd.min.js"

pin "quarterdeck/application", to: "quarterdeck/application.js"
pin "quarterdeck/controllers/chart_controller", to: "quarterdeck/controllers/chart_controller.js"
pin "quarterdeck/controllers/live_controller", to: "quarterdeck/controllers/live_controller.js"
