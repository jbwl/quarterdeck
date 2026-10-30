import { Controller } from "@hotwired/stimulus"

// Opens and closes the mobile navigation sheet (`<dialog class="sheet">`).
// Kept inside the engine so the dashboard needs no host JavaScript.
export default class extends Controller {
  static targets = ["panel"]

  open() {
    this.panelTarget.showModal()
  }

  close() {
    this.panelTarget.close()
  }

  // Clicking the dialog's backdrop targets the <dialog> itself.
  closeOnBackdrop(event) {
    if (event.target === this.panelTarget) this.close()
  }
}
