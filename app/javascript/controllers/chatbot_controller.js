import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="toggle"
export default class extends Controller {
  static targets = ["sidenav","hideGreeting", "inputField", "deleteButton", "chatContainer"];
  connect() {
    console.log("toggle controller connected");
  }
  opensideNav(event) {
    event.preventDefault()
    console.log("Called toggle");
    this.sidenavTarget.style.transform = "translateX(0)";
    this.chatContainerTarget.style.marginLeft = "250px"
  }

  closesideNav(event) {
    event.preventDefault()
    console.log("Called toggle");
    this.sidenavTarget.style.transform = "translateX(-250px)";
    this.chatContainerTarget.style.marginLeft = "0"
  }

  submit() {
    console.log("Called submit");
    this.hideGreetingTarget.classList.add("d-none")
    this.inputFieldTarget.classList.add("at-bottom")
  }

  icon(event) {
    console.log("icon clicked")
    event.preventDefault()
    this.deleteButtonTarget.classList.remove("d-none")
    document.addEventListener("click", this.outsideClick)
  }

   outsideClick = (event) => {
    if (this.element.contains(event.target)) return

    this.deleteButtonTarget.classList.add("d-none")

    document.removeEventListener("click", this.outsideClick)
  }
}
