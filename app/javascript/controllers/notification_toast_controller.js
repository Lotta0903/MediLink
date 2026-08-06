import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static values = {
    intervalMs: { type: Number, default: 10000 }
  }

  connect() {
    this.shownIds = new Set()
    this.poll()
    this.timer = setInterval(() => this.poll(), this.intervalMsValue)
  }

  disconnect() {
    if (this.timer) clearInterval(this.timer)
  }

  async poll() {
    try {
      const response = await fetch("/notifications/latest.json", {
        headers: { "Accept": "application/json" }
      })
      if (!response.ok) return
      const notifications = await response.json()
      notifications.reverse().forEach(notif => {
        if (!this.shownIds.has(notif.id)) {
          this.shownIds.add(notif.id)
          this.showToast(notif)
          this.playSound()
        }
      })
    } catch (err) {
      console.error("Notification polling failed:", err)
    }
  }

  showToast(notif) {
    const toast = document.createElement("div")
    toast.className = `notification-toast notification-toast--${notif.kind}`

    const icon = this.iconForKind(notif.kind)
    const title = this.titleForKind(notif.kind)

    const hint = (notif.kind === "reminder" && notif.with_food === "Yes")
      ? `<div class="notification-toast__hint">Take with food</div>`
      : ""

    toast.innerHTML = `
      <div class="notification-toast__icon">${icon}</div>
      <div class="notification-toast__content">
        <div class="notification-toast__title">${title}</div>
        <div class="notification-toast__message">${this.escapeHtml(notif.message)}</div>
        ${hint}
      </div>
      <button type="button" class="notification-toast__close" aria-label="Dismiss">✕</button>
    `

    this.element.appendChild(toast)

    requestAnimationFrame(() => {
      toast.classList.add("notification-toast--visible")
    })

    const dismiss = () => {
      clearTimeout(autoDismissTimer)
      toast.classList.remove("notification-toast--visible")
      toast.classList.add("notification-toast--exiting")
      setTimeout(() => toast.remove(), 500)
    }

    toast.querySelector(".notification-toast__close").addEventListener("click", dismiss)

    const autoDismissTimer = setTimeout(dismiss, 15000)
  }

  escapeHtml(str) {
    return String(str)
      .replace(/&/g, "&amp;")
      .replace(/</g, "&lt;")
      .replace(/>/g, "&gt;")
      .replace(/"/g, "&quot;")
      .replace(/'/g, "&#39;")
  }

  playSound() {
    try {
      const audioContext = new (window.AudioContext || window.webkitAudioContext)()
      const oscillator = audioContext.createOscillator()
      const gainNode = audioContext.createGain()

      oscillator.connect(gainNode)
      gainNode.connect(audioContext.destination)

      oscillator.type = "sine"
      oscillator.frequency.setValueAtTime(880, audioContext.currentTime)
      oscillator.frequency.setValueAtTime(1108, audioContext.currentTime + 0.1)

      gainNode.gain.setValueAtTime(0.3, audioContext.currentTime)
      gainNode.gain.exponentialRampToValueAtTime(0.01, audioContext.currentTime + 0.4)

      oscillator.start(audioContext.currentTime)
      oscillator.stop(audioContext.currentTime + 0.4)
    } catch (err) {
      console.error("Sound failed:", err)
    }
  }

  iconForKind(kind) {
    switch (kind) {
      case "reminder": return "⏰"
      case "missed": return "⚠️"
      case "follower_missed": return "👥"
      default: return "🔔"
    }
  }

  titleForKind(kind) {
    switch (kind) {
      case "reminder": return "Reminder"
      case "missed": return "Missed dose"
      case "follower_missed": return "Someone needs you"
      default: return "Notification"
    }
  }
}
