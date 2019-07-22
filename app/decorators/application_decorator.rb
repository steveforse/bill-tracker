# frozen_string_literal: true

# Allows draper to work with kaminari
class ApplicationDecorator < Draper::Decorator
  def self.collection_decorator_class
    PaginatingDecorator
  end
end
