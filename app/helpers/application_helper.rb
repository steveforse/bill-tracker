# Defines top-level, app-wide helpers
module ApplicationHelper
  def button_primary(text, url, icon=nil, html_options={})
    button_link_to(text, url, icon, 'primary', html_options)
  end

  def button_danger(text, url, icon=nil, html_options={})
    button_link_to(text, url, icon, 'danger', html_options)
  end

  def button_success(text, url, icon=nil, html_options={})
    button_link_to(text, url, icon, 'success', html_options)
  end

  def button_link_to(text, url, icon=nil, style='default', html_options={})
    raise unless ['primary', 'secondary', 'success', 'danger', 'warning', 'info', 'default'].include? style

    html_options[:class] ||= ''
    html_options[:class] += " btn btn-#{style}"
    link_to url, html_options do
      if icon
        content_tag(:i, '', class: ('fas fa-' + icon)) + text
      else
        text
      end
    end
  end

end
