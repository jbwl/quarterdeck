import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["startDate", "endDate"]

  submit() {
    const startDate = this.startDateTarget.value
    const endDate = this.endDateTarget.value

    if (startDate && endDate) {
      const url = new URL(window.location.href)
      url.searchParams.set("period", "custom")
      url.searchParams.set("start_date", startDate)
      url.searchParams.set("end_date", endDate)
      window.location.href = url.toString()
    }
  }
}
