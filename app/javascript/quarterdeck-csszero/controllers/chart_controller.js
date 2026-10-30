import { Controller } from "@hotwired/stimulus"
// Vendored Chart.js (UMD). Importing the "auto" bundle registers every
// controller on `window.Chart`. No CDN is used.
import "chart.js/auto"

// Mirrors CSS Zero's chart component so Quarterdeck charts look native to a
// CSS Zero UI, but renders with the Chart.js copy vendored inside the engine.
export default class extends Controller {
  static values = {
    type: { type: String, default: "line" },
    data: Object,
    options: Object
  }

  initialize() {
    const style = getComputedStyle(document.body)
    const Chart = window.Chart

    Chart.defaults.color = style.color
    Chart.defaults.datasets.line.tension = 0.35
    Chart.defaults.datasets.radar.tension = 0
    Chart.defaults.elements.arc.borderRadius = 12
    Chart.defaults.elements.bar.borderRadius = 12
    Chart.defaults.elements.point.radius = 0
    Chart.defaults.font.family = style.fontFamily
    Chart.defaults.font.size = 12
    Chart.defaults.maintainAspectRatio = false
    Chart.defaults.interaction.intersect = false
    Chart.defaults.plugins.legend.display = false
    Chart.defaults.plugins.legend.labels.usePointStyle = true
    Chart.defaults.plugins.legend.position = "bottom"
    Chart.defaults.plugins.tooltip.backgroundColor = style.backgroundColor
    Chart.defaults.plugins.tooltip.bodyColor = style.color
    Chart.defaults.plugins.tooltip.borderColor = style.borderColor
    Chart.defaults.plugins.tooltip.borderWidth = 1
    Chart.defaults.plugins.tooltip.boxPadding = 4
    Chart.defaults.plugins.tooltip.caretSize = 0
    Chart.defaults.plugins.tooltip.titleColor = style.color
    Chart.defaults.plugins.tooltip.usePointStyle = true
    Chart.defaults.scale.grid.color = style.borderColor
  }

  connect() {
    this.chart = new (window.Chart)(this.element, this.#settings)
  }

  disconnect() {
    if (this.chart) this.chart.destroy()
  }

  get #settings() {
    return { type: this.typeValue, data: this.dataValue, options: this.optionsValue }
  }
}
