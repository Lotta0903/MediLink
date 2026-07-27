import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["hours", "minutes", "hiddenName"]

  connect() {
    this.update()
  }

  update() {
    this.hiddenNameTarget.value = `${this.hoursTarget.value}:${this.minutesTarget.value}`
  }
}
