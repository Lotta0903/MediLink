import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  pulse(event) {
    const button = event.currentTarget
    button.classList.add("clicked")
    setTimeout(() => button.classList.remove("clicked"), 100)
  }
}
