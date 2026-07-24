import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["greeting", "date", "todayDate"]
  static values = { firstName: String }

  connect() {
    const hour = new Date().getHours()
    const greeting = hour < 12 ? "Good morning" : hour < 18 ? "Good afternoon" : "Good evening"
    const emoji = hour < 12 ? "☀️" : hour < 18 ? "🌤️" : "🌙"
    const dateString = new Date().toLocaleDateString("en-US", { weekday: "long", month: "long", day: "numeric" })

    if (this.hasGreetingTarget) this.greetingTarget.textContent = `${emoji} ${greeting}, ${this.firstNameValue}`
    if (this.hasDateTarget) this.dateTarget.textContent = dateString
    if (this.hasTodayDateTarget) this.todayDateTarget.textContent = dateString
  }
}
