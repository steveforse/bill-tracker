# frozen_string_literal: true

class ApplicationController < ActionController::Base
  def convert_to_sql_dates(attributes)
    attributes = [attributes] unless attributes.is_a? Array

    attributes.each do |attribute|
      date_value = params[controller_name.singularize][attribute]
      next unless date_value.present?
      params[controller_name.singularize][attribute] = Date.strptime(date_value, '%m/%d/%Y')
    end
  end
end
