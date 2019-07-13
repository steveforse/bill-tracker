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

$(document).on('turbolinks:load', () => {
  let baseConfig = {
    themeSystem: 'bootstrap',
    fixedWeekCount: false,
    height: 'auto',
    showNonCurrentDates: false,
    eventSources: [ '/calendar/events.json' ],
  }

  let calendarConfig = {
    plugins: [ dayGridPlugin, bootstrapPlugin, rrulePlugin ],
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
      let element = eventInfo.el
      let props = eventInfo.event.extendedProps

      element.classList.add('payment-late')

      tippy(element, {
        content: 'here it is'
      })
    }
  }

  let listConfig = {
    plugins: [ bootstrapPlugin, rrulePlugin, listPlugin ],
    header: { left: '', center: '', right: ''  },
    defaultView: 'listMonth',
    eventRender: (eventInfo) => {
      let props = eventInfo.event.extendedProps
      let number_to_currency = new Intl.NumberFormat('en-US', {
        style: 'currency',
        currency: 'USD'
      })

      // DOM element
      let element = eventInfo.el

      // Create alternative title
      let amount = number_to_currency.format(props.minimum_payment)
      let name = props.payee.nickname || props.payee.name
      let title = `${name} - ${amount}`

      // Modify title text before rendering
      $(element).find('.fc-list-item-title')
                .after(`<td class="text-right minimum-amount">${amount}</td>`)
    },
  }

  listConfig = {...baseConfig,  ...listConfig}
  calendarConfig = {...baseConfig, ...calendarConfig}

  window.calendar = new Calendar($('.calendar-container')[0], calendarConfig)
  window.list = new Calendar($('.list-container')[0], listConfig)
  window.calendar.render()
  window.list.render()
})
