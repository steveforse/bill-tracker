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
    plugins: [ dayGridPlugin, bootstrapPlugin, rrulePlugin, listPlugin ],
    themeSystem: 'bootstrap',
    fixedWeekCount: false,
    height: 'auto',
    defaultView: 'dayGridMonth',
    eventSources: [ '/calendar/events.json' ],
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
      },
    },
  }

  let listConfig = {
    header: { left: '', center: '', right: ''  },
    defaultView: 'listMonth'
  }
  listConfig = {...baseConfig,  ...listConfig}

  let calendarConfig = baseConfig

  window.calendar = new Calendar($('.calendar-container')[0], calendarConfig)
  window.list = new Calendar($('.list-container')[0], listConfig)
  window.calendar.render()
  window.list.render()
})
