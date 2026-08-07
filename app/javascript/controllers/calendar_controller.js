import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["dates", "currentDate", "dayInfoHeading", "dayInfoList"]
  static values = {
    myMedications: Object,
    followed: Object
  }

  connect() {
    this.months = [
      "January", "February", "March", "April", "May", "June",
      "July", "August", "September", "October", "November", "December"
    ]

    const today = new Date()
    this.year = today.getFullYear()
    this.month = today.getMonth()
    this.currentViewer = "me"
    this.clickedDay = today.getDate()

    this.render()
  }

  render() {
    this.renderGrid()
    this.showDayInfo(this.isoDate(this.year, this.month, this.clickedDay))
  }

  renderGrid() {
    const dayone = new Date(this.year, this.month, 1).getDay()
    const lastdate = new Date(this.year, this.month + 1, 0).getDate()
    const dayend = new Date(this.year, this.month, lastdate).getDay()
    const monthlastdate = new Date(this.year, this.month, 0).getDate()
    const today = new Date()
    const source = this.getMedicationsSource()

    let lit = ""

    for (let i = dayone; i > 0; i--) {
      lit += `<li class="inactive">${monthlastdate - i + 1}</li>`
    }

    for (let i = 1; i <= lastdate; i++) {
      const isToday = i === today.getDate() && this.month === today.getMonth() && this.year === today.getFullYear()
      const isSelected = i === this.clickedDay

      const classes = []
      if (isToday) classes.push("active")
      if (isSelected) classes.push("selected")

      const iso = this.isoDate(this.year, this.month, i)
      const hasMeds = (source[iso] || []).length > 0
      const dot = (hasMeds && !isToday && !isSelected) ? '<span class="calendar-dot"></span>' : ""

      lit += `<li class="${classes.join(" ")}" data-day="${i}" data-action="click->calendar#selectDay"><span class="calendar-day__number">${i}</span>${dot}</li>`
    }

    for (let i = dayend; i < 6; i++) {
      lit += `<li class="inactive">${i - dayend + 1}</li>`
    }

    this.currentDateTarget.innerText = `${this.months[this.month]} ${this.year}`
    this.datesTarget.innerHTML = lit
  }

  selectDay(event) {
    const day = parseInt(event.currentTarget.dataset.day, 10)
    if (!day) return

    this.clickedDay = day
    this.renderGrid()
    this.showDayInfo(this.isoDate(this.year, this.month, day))
  }

  switchViewer(event) {
    this.currentViewer = event.target.value

    const today = new Date()
    this.year = today.getFullYear()
    this.month = today.getMonth()
    this.clickedDay = today.getDate()

    this.render()
  }

  prevMonth() {
    this.month -= 1
    if (this.month < 0) {
      this.month = 11
      this.year -= 1
    }
    this.renderGrid()
  }

  nextMonth() {
    this.month += 1
    if (this.month > 11) {
      this.month = 0
      this.year += 1
    }
    this.renderGrid()
  }

  showDayInfo(dateStr) {
    const source = this.getMedicationsSource()
    const meds = (source[dateStr] || [])
      .slice()
      .sort((a, b) => (a.reminder_time || "").localeCompare(b.reminder_time || ""))

    const [y, m, d] = dateStr.split("-").map(Number)
    this.dayInfoHeadingTarget.innerText = new Date(y, m - 1, d).toLocaleDateString("en-US", {
      month: "long", day: "numeric", year: "numeric"
    })

    if (meds.length === 0) {
      this.dayInfoListTarget.innerHTML = `<p class="text-muted mb-0">No medications scheduled.</p>`
      return
    }

    const isMine = this.currentViewer === "me"

    this.dayInfoListTarget.innerHTML = meds.map((med) => {
      const clickableClass = isMine ? "calendar-day-info__row--clickable" : ""
      const modalAttrs = isMine
        ? `data-action="click->medication-modal#open" data-medication-id="${med.id}"`
        : ""

      const badge = this.statusBadge(med.status)

      return `
        <div class="calendar-day-info__row ${clickableClass}" ${modalAttrs}>
          <span class="calendar-day-info__time">${this.formatTime(med.reminder_time)}</span>
          <span class="calendar-day-info__name">${this.escapeHtml(med.name)}</span>
          <span class="calendar-day-info__dosage">${this.escapeHtml(med.dosage || "")}</span>
          ${badge}
          <i class="bi bi-chevron-right calendar-day-info__chevron"></i>
        </div>
      `
    }).join("")
  }

  statusBadge(status) {
    if (status === "taken") return '<span class="calendar-day-info__taken-badge">Taken</span>'
    if (status === "missed") return '<span class="calendar-day-info__missed-badge">Missed</span>'
    return ""
  }

  getMedicationsSource() {
    return this.currentViewer === "me"
      ? this.myMedicationsValue
      : (this.followedValue[this.currentViewer] || {})
  }

  isoDate(year, month, day) {
    const y = year
    const m = String(month + 1).padStart(2, "0")
    const d = String(day).padStart(2, "0")
    return `${y}-${m}-${d}`
  }

  formatTime(value) {
    if (!value) return "--:--"
    return value.slice(0, 5)
  }

  escapeHtml(value) {
    const div = document.createElement("div")
    div.textContent = value ?? ""
    return div.innerHTML
  }
}
