# frozen_string_literal: true

require 'rspec/expectations'
require 'date_validator'

def validate_date_of(attr)
  ValidateDateOfMatcher.new(attr)
end

class ValidateDateOfMatcher
  def initialize(attribute)
    @attribute = attribute
    @subject = nil
    @validator = nil
    @match_options = {}
  end

  def failure_message
    'expected to have date validator'
  end

  def description
    "have a date validator for attribute :#{@attribute}"
  end

  def matches?(subject)
    @subject = subject
    @validator = validator

    validators_exist_for_attribute? && date_validator_on_attribute? && match_options?
  end

  def after(after_date_attribute)
    @match_options[:after] = after_date_attribute
    self
  end

  def allow_blank
    @match_options[:allow_blank] = true
    self
  end

  private

  def model
    @subject.class
  end

  def validator
    validators = model._validators[@attribute]
    validators.each do |validator|
      return validator if validator.is_a? ::ActiveModel::Validations::DateValidator
    end
    nil
  end

  def validators_exist_for_attribute?
    model._validators[@attribute].any?
  end

  def date_validator_on_attribute?
    @validator.present?
  end

  def match_options?
    ret_val = true

    @match_options.each do |option, value|
      ret_val &&= (@validator.options[option] == value)
    end
    ret_val
  end
end
