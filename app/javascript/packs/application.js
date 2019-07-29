// Load bootstrap javascript and css (with our overrides)
import 'bootstrap'
import '../stylesheets/bootstrap.scss'

// Replaces standard checkboxes with something a little easier to read
import 'bootstrap4-toggle'
import 'bootstrap4-toggle/css/bootstrap4-toggle.min.css'

// Use our custom datepicker
import DatePicker from '../datepicker'
import '../datepicker/stylesheets/datepicker.scss'

// Import our application css
import '../stylesheets/application.scss'
import '../stylesheets/navbar.scss'

// Import the logo
import '../images/logo.png'

import $ from 'jquery'

require('@rails/ujs').start()
require('turbolinks').start()
require('@rails/activestorage').start()
require('channels')

// Run this on every page load
document.addEventListener('turbolinks:load', () => {
  $('.simple_form input[type="checkbox"]').bootstrapToggle()

  const datepickers = []
  document.querySelectorAll('input.datepicker').forEach(element => {
    datepickers.push(new DatePicker(element, { rrule: element.dataset.rrule }))
  })
})
