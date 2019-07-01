# frozen_string_literal: true

# This implements a datepicker components with input-group and html data-attrs
# rubocop: disable Metrics/AbcSize
class DatepickerInput < SimpleForm::Inputs::Base
  def input(wrapper_options)
    # Apply error class to the input-group to make error message appear
    validation_class = ' '
    validation_class += (errors ? wrapper_options[:error_class] : wrapper_options[:valid_class])

    # Requires an explicit id; no implicit ids like smarter libraries
    datapicker_target = 'datepicker-' + attribute_name.to_s.dasherize

    # Required input class for tempus dominus
    input_html_classes << 'datetimepicker-input'

    # Add data attributes on input field to toggle calendar
    input_html_options['data-target'] = '#' + datapicker_target
    input_html_options['data-toggle'] = 'datetimepicker'
    input_html_options['autocomplete'] = 'off'

    # Merge our attributes and classes with whatever comes from wrapper options and html options
    merged_input_options = merge_wrapper_options(input_html_options, wrapper_options)

    # date, datepicker are tempus dominus-rquired; datepicker-group for init binding
    template.content_tag(:div,
                         class: ('input-group date datepicker datepicker-group' + validation_class),
                         id: datapicker_target,
                         # another required data attributed by tempus dominus
                         'data-target-input' => 'nearest') do
      template.concat @builder.text_field(attribute_name, merged_input_options)
      template.concat append_calendar(datapicker_target)
    end
  end

  def append_calendar(datapicker_target)
    template.content_tag(:div, class: 'input-group-append',
                               'data-toggle' => 'datetimepicker',
                               'data-target' => ('#' + datapicker_target)) do
      template.concat template.content_tag(:div, class: 'input-group-text') {
        template.content_tag(:span, '', class: 'fas fa-calendar-alt')
      }
    end
  end
end
# rubocop: enable Metrics/AbcSize
