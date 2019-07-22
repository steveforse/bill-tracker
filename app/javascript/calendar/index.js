// Full Calendar and plugins
import { Calendar } from '@fullcalendar/core'
import dayGridPlugin from '@fullcalendar/daygrid'
import bootstrapPlugin from '@fullcalendar/bootstrap'
import rrulePlugin from '@fullcalendar/rrule'
import listPlugin from '@fullcalendar/list'

// Full calendar stylings
import '@fullcalendar/core/main.css'
import '@fullcalendar/daygrid/main.css'
import '@fullcalendar/bootstrap/main.css'
import '@fullcalendar/list/main.css'

// Calendar styles and full-calendar overrides
import './stylesheets/calendar.scss'

// Calendar event tooltips
import tippy from 'tippy.js'
import 'tippy.js/themes/light-border.css'

// Utility
import _ from 'lodash'

$(document).on('turbolinks:before-cache', () => {
  let calendar = document.querySelector('.calendar-container')
  if (calendar) { calendar.innerHTML = '' }

  let list = document.querySelector('.list-container')
  if (list) { list.innerHTML = '' }

  let popup = document.querySelector('.tippy-popper')
  if (popup) { popup.parentNode.removeChild(popup) }
})

$(document).on('turbolinks:load', () => {
  if (!document.querySelector('.calendar-container')) { return }

  let total = {
    minimumTotal: 0,
    actualPaid: 0,
  }

  const numberToCurrency = new Intl.NumberFormat('en-US', {
    style: 'currency',
    currency: 'USD'
  })

  let totals = {
    totalDue: 0,
    amountPaid: 0

  }

  let updateTotalsHTML = (totals) => {
    document.querySelector('.totals-container').innerHTML = `
      <table class="table table-sm">
        <tbody>
          <tr>
            <td class="text-right font-weight-bold">Minimum Total</td>
            <td class="text-left">${numberToCurrency.format(totals.minimumTotal)}</td>
          </tr>
          <tr>
            <td class="text-right font-weight-bold">Amount Paid To Date</td>
            <td class="text-left">${numberToCurrency.format(totals.actualPaid)}</td>
          <tr>
        </tbody>
      </table>
    `
  }

  let getPaymentClass = (dueDate, payments) => {
    let today = moment.utc().format('YYYY-MM-DD')
    let status = null

    payments.forEach(payment => {
      if (payment.due_date === dueDate) {
        if (payment.date <= dueDate) { status = 'paid-on-time' }
        if (payment.date > dueDate && !status) { status = 'paid-late' }
      }
    })

    if (!status) { status = (today > dueDate) ? 'unpaid-late' : 'unpaid-due' }
    return status
  }

  let getPaymentAmounts = (dueDate, payments) => {
    let amounts = {}
    payments.forEach(payment => {
      if (payment.due_date === dueDate) {
        if (!amounts[payment.due_date]) { amounts[payment.due_date] = 0 }
        amounts[payment.due_date] += Number(payment.amount)
      }
    })
    return amounts
  }

  const baseConfig = {
    themeSystem: 'bootstrap',
    fixedWeekCount: false,
    height: 'auto',
    showNonCurrentDates: false,
    eventSources: ['/calendar/events.json']
  }

  let calendarConfig = {
    plugins: [dayGridPlugin, bootstrapPlugin, rrulePlugin],
    defaultView: 'dayGridMonth',
    customButtons: {
      next: {
        click: () => {
          calendar.next()
          list.next()
        }
      },
      prev: {
        click: () => {
          calendar.prev()
          list.prev()
        }
      },
      today: {
        text: 'Today',
        click: () => {
          calendar.today()
          list.today()
        }
      }
    },
    eventRender: (eventInfo) => {
      const element = eventInfo.el
      element.classList.add('payment')

      const dueDate = moment.utc(eventInfo.event.start).format('YYYY-MM-DD')
      const today = moment.utc().format('YYYY-MM-DD')
      const props = eventInfo.event.extendedProps

      const paymentClass = getPaymentClass(dueDate, props.payments)
      element.classList.add(paymentClass)

      let statusText = _.startCase(_.camelCase(paymentClass))
      let button = ''
      let amountPaidRow = ''
      if (paymentClass.startsWith('unpaid')) {
        button = `<a href="/schedules/${props.schedule_id}/payments/new"
                  class="btn btn-sm btn-primary">Make Payment</a><br/>`
      } else {
        let amounts = getPaymentAmounts(dueDate, props.payments)
        let amountPaid = amounts[dueDate] || props.minimum_payment
        amountPaidRow = `
          <tr>
            <td class="text-right font-weight-bold">Amount Paid</td>
            <td class="text-left">${numberToCurrency.format(amountPaid)}</td>
          </tr>`
      }

      let popupContent = `
        <table class="table table-sm table-borderless">
          <tr>
            <td class="text-right font-weight-bold">Payee Name</td>
            <td class="text-left">
              <a href="/payees/${props.payee.id}">${props.payee.name}</a>
            </td>
          <tr>
          <tr>
            <td class="text-right font-weight-bold">Schedule Name</td>
            <td class="text-left">
              <a href="/schedules/${props.schedule_id}">${eventInfo.event.title}</a>
            </td>
          </tr>
          <tr>
            <td class="text-right font-weight-bold">Autopay</td>
            <td class="text-left">
              ${props.autopay ? 'Enabled' : 'Disabled'}
            </td>
          </tr>
          <tr>
            <td class="text-right font-weight-bold">Payment Status</td>
            <td class="text-left">${statusText}</td>
          </tr>
          <tr>
            <td class="text-right font-weight-bold">Minimum Due</td>
            <td class="text-left">${numberToCurrency.format(props.minimum_payment)}</td>
          </tr>
          ${amountPaidRow}
        </table>
        ${button}
      `

      tippy(element, {
        content: popupContent,
        arrow: true,
        trigger: 'click',
        theme: 'light-border',
        interactive: true,
        boundary: 'viewport'
      })
    }
  }

  let listConfig = {
    plugins: [bootstrapPlugin, rrulePlugin, listPlugin],
    header: { left: '', center: '', right: '' },
    defaultView: 'listMonth',
    eventRender: (eventInfo) => {
      const dueDate = moment.utc(eventInfo.event.start).format('YYYY-MM-DD')
      const props = eventInfo.event.extendedProps
      const paymentClass = getPaymentClass(dueDate, props.payments)

      // Determine amount to display (actual or expected minimum)
      let amounts = getPaymentAmounts(dueDate, props.payments)
      let amount = amounts[dueDate] || props.minimum_payment

      // Update totals
      totals.minimumTotal += Number(props.minimum_payment)
      if (paymentClass.startsWith('paid') && amounts[dueDate]) {
        totals.actualPaid += amounts[dueDate]
      }

      updateTotalsHTML(totals)

      amount = numberToCurrency.format(amount)
      const name = props.payee.nickname || props.payee.name

      // Modify title text before rendering
      eventInfo.el.querySelector('.fc-list-item-title')
                  .insertAdjacentHTML('afterend',
                                      `<td class="text-right minimum-amount">${amount}</td>`)


      let dot = eventInfo.el.querySelector('.fc-event-dot')
      dot.classList.add('payment')
      dot.classList.add(paymentClass)
    },
    eventSourceSuccess: (content, xhr) => {
      totals = {
        minimumTotal: 0,
        actualPaid: 0
      }
      updateTotalsHTML(totals)
    }
  }

  listConfig = { ...baseConfig, ...listConfig }
  calendarConfig = { ...baseConfig, ...calendarConfig }

  window.list = new Calendar(document.querySelector('.list-container'), listConfig)
  list.render()

  window.calendar = new Calendar(document.querySelector('.calendar-container'), calendarConfig)
  calendar.render()
})
