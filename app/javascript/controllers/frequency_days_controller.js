import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["checkbox", "hiddenName"]

  connect() {
    this.update()
  }

  update() {
    const selected = this.checkboxTargets.filter((cb) => cb.checked).map((cb) => cb.value)
    this.hiddenNameTarget.value = selected.join(",")
  }
}
