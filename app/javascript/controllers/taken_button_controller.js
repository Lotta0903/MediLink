import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  flash(event) {
    event.preventDefault()

    const button = event.currentTarget
    const form = button.closest("form")

    button.classList.add("flash-success")

    setTimeout(() => form.requestSubmit(), 400)
  }
}
