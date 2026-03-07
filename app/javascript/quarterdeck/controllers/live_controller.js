import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["activeVisitors", "currentPages", "recentEvents"]
  static values = { url: String }

  connect() {
    this.poll()
  }

  disconnect() {
    if (this.timer) clearTimeout(this.timer)
  }

  poll() {
    fetch(this.urlValue)
      .then(response => response.json())
      .then(data => this.update(data))
      .catch(() => {})
      .finally(() => {
        this.timer = setTimeout(() => this.poll(), 5000)
      })
  }

  update(data) {
    this.activeVisitorsTarget.textContent = data.active_visitors

    if (this.hasCurrentPagesTarget) {
      if (data.current_pages.length > 0) {
        this.currentPagesTarget.innerHTML = data.current_pages.map(p =>
          `<tr class="hover:bg-gray-50">
            <td class="px-6 py-3 text-sm text-gray-900 truncate max-w-xs">${this.escapeHtml(p.url)}</td>
            <td class="px-6 py-3 text-sm text-gray-600 text-right">${p.count}</td>
          </tr>`
        ).join("")
      } else {
        this.currentPagesTarget.innerHTML = `<tr><td colspan="2" class="px-6 py-8 text-sm text-gray-400 text-center">No active pages</td></tr>`
      }
    }

    if (this.hasRecentEventsTarget) {
      this.recentEventsTarget.innerHTML = data.recent_events.map(e =>
        `<tr class="hover:bg-gray-50">
          <td class="px-6 py-3 text-sm text-gray-900 whitespace-nowrap">${this.escapeHtml(e.time)}</td>
          <td class="px-6 py-3 text-sm">
            <span class="inline-flex items-center px-2 py-0.5 rounded-md text-xs font-medium bg-indigo-50 text-indigo-700">${this.escapeHtml(e.name)}</span>
          </td>
          <td class="px-6 py-3 text-sm text-gray-500 font-mono">${this.escapeHtml(e.visitor || "")}</td>
        </tr>`
      ).join("")
    }
  }

  escapeHtml(text) {
    const div = document.createElement("div")
    div.textContent = text || ""
    return div.innerHTML
  }
}
