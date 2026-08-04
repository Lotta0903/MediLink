import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["modal", "content"]

  open(event) {
    const id = event.currentTarget.dataset.medicationId
    const content = this.contentTargets.find((content) => content.dataset.medicationIdValue === id)

    if (!content) return

    this.contentTargets.forEach((content) => content.classList.add("d-none"))
    content.classList.remove("d-none")
    this.modalTarget.classList.remove("d-none")
    document.body.classList.add("no-scroll")
  }

  close(event) {
    if (event.type !== "keydown" && event.target !== this.modalTarget && !event.target.closest(".medication-modal-close")) {
      return
    }

    this.modalTarget.classList.add("d-none")
    this.contentTargets.forEach((content) => content.classList.add("d-none"))
    document.body.classList.remove("no-scroll")
  }

  stop(event) {
    event.stopPropagation()
  }
}
