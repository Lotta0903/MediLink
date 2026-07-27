import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["select", "customInput", "hiddenName"]

  connect() {
    this.update()
  }

  update() {
    const customValue = this.customInputTarget.value.trim()
    this.hiddenNameTarget.value = customValue !== "" ? customValue : this.selectTarget.value
  }
}
