// This file is automatically compiled by Webpack, along with any other files
// present in this directory. You're encouraged to place your actual application logic in
// a relevant structure within app/javascript and only use these pack files to reference
// that code so it'll be compiled.

require("@rails/ujs").start()
require("turbolinks").start()
require("@rails/activestorage").start()
require("channels")

// Load bootstrap javascript and css (with our overrides)
import 'bootstrap'
import '../stylesheets/bootstrap.scss'

// Bootstrap4 datepicker
import 'tempusdominus-bootstrap-4'
import 'tempusdominus-bootstrap-4/build/css/tempusdominus-bootstrap-4.css'

// Replaces standard checkboxes with something a little easier to read
import 'bootstrap4-toggle'
import 'bootstrap4-toggle/css/bootstrap4-toggle.css'

// Import our application css
import '../stylesheets/application.scss'

// Run this on every page load
$(document).on('turbolinks:load', () => {
  $('.simple_form .datepicker-group').datetimepicker({ format: 'L' })
  $('.simple_form input[type="checkbox"]').bootstrapToggle()
})
