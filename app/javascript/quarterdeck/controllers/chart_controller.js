import { Controller } from "@hotwired/stimulus"
import "chart.js/auto"

export default class extends Controller {
  static values = {
    type: { type: String, default: "line" },
    labels: Array,
    data: Array,
    label: { type: String, default: "" },
    colors: Array
  }

  connect() {
    this.buildChart()
  }

  disconnect() {
    if (this.chart) {
      this.chart.destroy()
    }
  }

  buildChart() {
    const ctx = this.element.getContext("2d")
    const chartType = this.typeValue

    const defaultColors = [
      "#6366f1", "#818cf8", "#a5b4fc", "#c7d2fe", "#e0e7ff",
      "#4f46e5", "#4338ca", "#3730a3", "#312e81", "#1e1b4b"
    ]
    const colors = this.hasColorsValue ? this.colorsValue : defaultColors

    const config = {
      type: chartType,
      data: this.chartData(chartType, colors),
      options: this.chartOptions(chartType)
    }

    const ChartJS = window.Chart
    this.chart = new ChartJS(ctx, config)
  }

  chartData(type, colors) {
    if (type === "doughnut" || type === "pie") {
      return {
        labels: this.labelsValue,
        datasets: [{
          data: this.dataValue,
          backgroundColor: colors.slice(0, this.dataValue.length),
          borderWidth: 0
        }]
      }
    }

    return {
      labels: this.labelsValue,
      datasets: [{
        label: this.labelValue,
        data: this.dataValue,
        borderColor: "#6366f1",
        backgroundColor: type === "bar" ? "#6366f1" : "rgba(99, 102, 241, 0.1)",
        fill: type === "line",
        tension: 0.3,
        borderWidth: 2,
        pointRadius: 2,
        pointHoverRadius: 4
      }]
    }
  }

  chartOptions(type) {
    const base = {
      responsive: true,
      maintainAspectRatio: false,
      plugins: {
        legend: {
          display: type === "doughnut" || type === "pie",
          position: "bottom"
        }
      }
    }

    if (type === "line" || type === "bar") {
      base.scales = {
        x: {
          grid: { display: false },
          ticks: { font: { size: 11 } }
        },
        y: {
          beginAtZero: true,
          grid: { color: "rgba(0,0,0,0.05)" },
          ticks: { font: { size: 11 } }
        }
      }
    }

    return base
  }
}
