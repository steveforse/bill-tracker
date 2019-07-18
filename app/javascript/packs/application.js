require("@rails/ujs").start()
require("turbolinks").start()
require("@rails/activestorage").start()
require("channels")

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

// Run this on every page load
$(document).on('turbolinks:load', () => {
  $('.simple_form input[type="checkbox"]').bootstrapToggle()

  document.querySelectorAll('input.datepicker').forEach(element => {
    new DatePicker(element, { rrule: element.dataset.rrule })
  })
})

