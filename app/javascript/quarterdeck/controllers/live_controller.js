import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["activeVisitors", "currentPages", "recentEvents"]
  static values = { url: String, interval: { type: Number, default: 5000 } }

  connect() {
    this.poll()
  }

  disconnect() {
    if (this.timer) clearTimeout(this.timer)
  }

  poll() {
    fetch(this.urlValue, { headers: { Accept: "application/json" } })
      .then((response) => response.json())
      .then((data) => this.update(data))
      .catch(() => {})
      .finally(() => {
        this.timer = setTimeout(() => this.poll(), this.intervalValue)
      })
  }

  update(data) {
    if (this.hasActiveVisitorsTarget) {
      this.activeVisitorsTarget.textContent = data.active_visitors
    }

    if (this.hasCurrentPagesTarget) {
      if (data.current_pages.length > 0) {
        this.currentPagesTarget.innerHTML = data.current_pages
          .map((page) => this.row([this.cell(page.url), this.cell(page.count, "text-end")]))
          .join("")
      } else {
        this.currentPagesTarget.innerHTML = this.emptyRow(2, "No active pages")
      }
    }

    if (this.hasRecentEventsTarget) {
      this.recentEventsTarget.innerHTML = data.recent_events
        .map((event) =>
          this.row([
            this.cell(event.time, "whitespace-nowrap"),
            this.cell(`<span class="badge">${this.escapeHtml(event.name)}</span>`),
            this.cell(event.visitor || "", "text-subtle")
          ])
        )
        .join("")
    }
  }

  row(cells) {
    return `<tr>${cells.join("")}</tr>`
  }

  cell(content, classes = "") {
    return `<td class="${classes}">${content}</td>`
  }

  emptyRow(colspan, label) {
    return `<tr><td colspan="${colspan}" class="text-center text-subtle">${this.escapeHtml(label)}</td></tr>`
  }

  escapeHtml(text) {
    const div = document.createElement("div")
    div.textContent = text == null ? "" : text
    return div.innerHTML
  }
}
