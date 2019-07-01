# frozen_string_literal: true

# Defines top-level, app-wide helpers
module ApplicationHelper
  #########
  # FLASH #
  #########
  def flash_class(level)
    case level
    when 'notice' then 'alert alert-info'
    when 'success' then 'alert alert-success'
    when 'error' then 'alert alert-danger'
    when 'alert' then 'alert alert-warning'
    end
  end

  #########
  # ICONS #
  #########
  # Add icon_names to stuff!
  def icon(icon_name)
    content_tag(:span, '', class: "fas fa-#{icon_name}")
  end

  ###########
  # BUTTONS #
  ###########
  def button_cancel(url, button_text = 'Cancel')
    link_to(button_text, url, class: 'btn btn-outline-secondary')
  end

  def button_reset(text = 'Reset Form')
    button_tag(text, type: 'reset', class: 'btn btn-outline-secondary')
  end

  def button_primary(text, url, icon_name = nil, html_options = {})
    button_link_to(text, url, icon_name, 'primary', html_options)
  end

  def button_danger(text, url, icon_name = nil, html_options = {})
    button_link_to(text, url, icon_name, 'danger', html_options)
  end

  def button_success(text, url, icon_name = nil, html_options = {})
    button_link_to(text, url, icon_name, 'success', html_options)
  end

  def button_link_to(text, url, icon_name = nil, style = 'default', html_options = {})
    raise unless %w[primary secondary success danger warning info default].include? style

    html_options[:class] ||= ''
    html_options[:class] += " btn btn-#{style}"
    link_to url, html_options do
      if icon_name
        icon(icon_name) + ' ' + text
      else
        text
      end
    end
  end
end
