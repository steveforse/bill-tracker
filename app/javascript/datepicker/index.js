// Load bootstrap javascript and css (with our overrides)
import 'bootstrap'

// Used for calendar DOM popup
import tippy from 'tippy.js'
import 'tippy.js/themes/light-border.css'

// For time manipulation
import moment from 'moment'
import { rrulestr } from 'rrule'

export default class DatePicker {
  constructor (input, config = {}) {
    // Keep track of how we initialized datepicker
    this.input = input
    this.config = config

    this.popup = null // Tippy.js popup
    this.DOM = null // Currently rendered DOM in popup
    this.selectedDate = null // Date currently selected by user in DOM

    // Attributes based on config
    this.rrule = null // RRule object. Calendar will only enable matching dates.

    // Get ready for first render
    this.parseConfig() // Initialize datepicker based on config settings
    this.parseInputValue() // Will attempt to set selecteDate
    this.modifyInputField() // Will add autocomplete=off
    this.addPopupToInputField() // Display calendar when clicking on input field

    // Render calendar DOM for popup
    this.generateCalendarDOM(this.selectedDate || moment.utc())
  }

  parseConfig () {
    if (this.config.rrule) { this.rrule = rrulestr(this.config.rrule) }
  }

  parseInputValue () {
    this.selectedDate = moment.utc(this.input.value, 'MM/DD/YYYY')
    if (!this.selectedDate.isValid()) {
      this.selectedDate = null
      this.input.value = ''
    }
  }

  modifyInputField () {
    this.input.setAttribute('autocomplete', 'off')
  }

  /// ////////
  // Popup //
  /// ////////

  addPopupToInputField () {
    let element = this.input
    if (element.parentNode.classList.contains('input-group')) { element = element.parentNode }
    this.popup = tippy(element, {
      content: this.DOM,
      theme: 'light-border',
      arrow: true,
      placement: 'bottom-start',
      trigger: 'click',
      interactive: true
    })
  }

  /// ////////////////
  // Calendar View //
  /// ////////////////

  setActiveClass (buttonValue) {
    const element = this.DOM
      .querySelector(`td.button[data-value="${buttonValue}"]`)
    if (element) { element.classList.add('active') }
  }

  setSelectedDate (date) {
    this.selectedDate = moment.utc(date)
    this.generateCalendarDOM(date)
  }

  setInputValue (day) {
    this.input.value = moment.utc(day.dataset.value, 'YYYY-MM-DD').format('L')
  }

  addEventsToCalendarDOM () {
    // Allows clicking on calendar days
    Array.from(this.DOM.querySelectorAll('tbody td.button')).forEach((day) => {
      day.addEventListener('click', (e) => {
        this.setSelectedDate(e.target.dataset.value)
        this.setInputValue(e.target)
      })
    })

    const nextButton = this.DOM.querySelector('td[data-action="month-next"]')
    if (nextButton) {
      nextButton.addEventListener('click', () => {
        const nextMonthDate = moment.utc(nextButton.dataset.month)
        this.generateCalendarDOM(nextMonthDate)
      })
    }

    const prevButton = this.DOM.querySelector('td[data-action="month-prev"]')
    if (prevButton) {
      prevButton.addEventListener('click', () => {
        const prevMonthDate = moment.utc(prevButton.dataset.month)
        this.generateCalendarDOM(prevMonthDate)
      })
    }

    const monthButton = this.DOM.querySelector('td[data-action="month-select"]')
    if (monthButton) {
      monthButton.addEventListener('click', () => {
        const year = monthButton.dataset.year
        this.generateMonthSelectDOM(year)
      })
    }
  }

  generateCalendarDOM (dateInMonth) {
    const startDate = moment.utc(dateInMonth).startOf('month')
    const endDate = moment.utc(dateInMonth).endOf('month')

    const monthHeader = `
      <tr>
        <td class="button"
            data-action="month-prev"
            data-month="${moment.utc(startDate).subtract(1, 'month').format('YYYY-MM')}"
        ><span class="fas fa-chevron-left"></td>
        <td colspan="5"
            class="button""
            data-action="month-select"
            data-year="${moment.utc(startDate).year()}"
        >${moment.utc(startDate).format('MMMM YYYY')}</td>
        <td class="button"
            data-action="month-next"
            data-month="${moment.utc(startDate).add(1, 'month').format('YYYY-MM')}"
        ><span class="fas fa-chevron-right"></td>
      </tr>`

    let dowHeader = moment.weekdaysMin()
      .map((dow) => { return `<th class="day-of-week">${dow}</th>` })
      .join('')
    dowHeader = `<tr>${dowHeader}</tr>`

    const calendarStart = moment.utc(startDate).startOf('week')
    const calendarEnd = moment.utc(endDate).endOf('week')

    let datesAllowed = null
    if (this.rrule) {
      datesAllowed = this.rrule
        .between(calendarStart.toDate(), calendarEnd.toDate())
        .map((day) => { return moment.utc(day).format('YYYY-MM-DD') })
    }

    let rows = ''
    for (let current = moment.utc(calendarStart); current < calendarEnd; current = current.add(1, 'days')) {
      if (current.day() === 0) { rows += '<tr>' }

      // Allows button to be clickable
      let dayClass = 'button'
      if (datesAllowed) {
        if (!datesAllowed.includes(current.format('YYYY-MM-DD'))) {
          dayClass = 'disabled'
        }
      }
      if (current < startDate || current > endDate) { dayClass += ' non-current' }
      if (current.format('YYYY-MM-DD') === moment.utc().format('YYYY-MM-DD')) { dayClass += ' today' }
      rows += `<td class="${dayClass}"
                   data-value=${current.format('YYYY-MM-DD')}
               >${current.date()}</td>`
      if (current.day() === 6) { rows += '</tr>' }
    }

    const table = `
      <table class="table table-sm table-borderless datepicker-table">
        <thead>
          ${monthHeader}
          ${dowHeader}
        </thead>
        <tbody>
          ${rows}
        </tbody>
      </table>
    `
    const template = document.createElement('template')
    template.innerHTML = table.trim()
    this.DOM = template.content.firstChild
    this.popup.setContent(this.DOM)
    // selecteDate is null on first render when input field value is invalid
    if (this.selectedDate) { this.setActiveClass(this.selectedDate.format('YYYY-MM-DD')) }
    this.addEventsToCalendarDOM()
  }

  /// ////////////////////
  // Month Select View //
  /// ////////////////////
  generateMonthSelectDOM (year) {
    const monthSelectHeader = `
      <tr>
        <td class="button"
            data-action="year-prev"
            data-year="${moment.utc(year, 'YYYY').subtract(1, 'year').format('YYYY')}"
        ><span class="fas fa-chevron-left"></td>
        <td colspan="4"
            class="header monthHeader"
        >${moment.utc(year, 'YYYY').format('YYYY')}</td>
        <td class="button"
            data-action="year-next"
            data-year="${moment.utc(year, 'YYYY').add(1, 'year').format('YYYY')}"
        ><span class="fas fa-chevron-right"></td>
      </tr>
    `

    let rows = '<tr><td></td>'
    for (let i = 1; i <= 12; i++) {
      rows += `<td class="button"
                   data-value="${moment.utc(year, 'YYYY').set('month', i - 1).format('YYYY-MM')}"
               >${moment.monthsShort()[i - 1]}</td>`
      if (i % 4 === 0) { rows += '<td></td></tr><tr><td></td>' }
    }
    rows += '</tr>'

    const table = `
      <table class="table table-sm table-borderless datepicker-table">
        <thead>
          ${monthSelectHeader}
        </thead>
        <tbody>
          ${rows}
        </tbody>
      </table>
    `

    const template = document.createElement('template')
    template.innerHTML = table.trim()
    this.DOM = template.content.firstChild
    this.popup.setContent(this.DOM)
    if (this.selectedDate) { this.setActiveClass(this.selectedDate.format('YYYY-MM')) }
    this.addEventsToMonthSelect(year)
  }

  addEventsToMonthSelect (year) {
    // Allows clicking on calendar days
    Array.from(this.DOM.querySelectorAll('tbody td')).forEach((day) => {
      day.addEventListener('click', (e) => {
        const monthYear = moment.utc(e.target.dataset.value)
        this.generateCalendarDOM(monthYear)
      })
    })

    const nextButton = this.DOM.querySelector('td[data-action="year-next"]')
    if (nextButton) {
      nextButton.addEventListener('click', (e) => {
        const nextYear = moment.utc(year, 'YYYY').add(1, 'year')
        this.generateMonthSelectDOM(nextYear)
      })
    }

    const prevButton = this.DOM.querySelector('td[data-action="year-prev"]')
    if (prevButton) {
      prevButton.addEventListener('click', (e) => {
        const prevYear = moment.utc(year, 'YYYY').subtract(1, 'year')
        this.generateMonthSelectDOM(prevYear)
      })
    }
  }
}
