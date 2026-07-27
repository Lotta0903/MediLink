import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="toggle"
export default class extends Controller {
  static targets = ["show", "hideable", "hide", "input", "display"];
  connect() {
    console.log("toggle controller connected");
  }
  call(event) {
    event.preventDefault()
    console.log("Called toggle");
    if(this.hideableTarget.classList.contains("d-none")){
      this.hideableTarget.classList.remove("d-none");
      this.showTarget.classList.add("d-none")
    }else if(this.showTarget.classList.contains("d-none")){
      this.hideableTarget.classList.add("d-none");
      this.showTarget.classList.remove("d-none")
    }
  }

  submit() {
    console.log("Called submit");
    this.hideTarget.classList.add("d-none")
    this.inputTarget.classList.add("at-bottom")
  }

  icon(event) {
    console.log("icon clicked")
    event.preventDefault()
    this.displayTarget.classList.remove("d-none")
    document.addEventListener("click", this.outsideClick)
  }

   outsideClick = (event) => {
    if (this.element.contains(event.target)) return

    this.displayTarget.classList.add("d-none")

    document.removeEventListener("click", this.outsideClick)
  }
}
