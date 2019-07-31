# frozen_string_literal: true

# Should contain functions common to all controllers
class ApplicationController < ActionController::Base
  before_action :authenticate_user!

  def convert_to_sql_dates(attributes)
    attributes = [attributes] unless attributes.is_a? Array

    attributes.each do |attribute|
      date_value = params[controller_name.singularize][attribute]
      next if date_value.blank?

      params[controller_name.singularize][attribute] = Date.strptime(date_value, '%m/%d/%Y')
    end
  end
end
