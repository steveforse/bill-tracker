# frozen_string_literal: true

# Allows draper to work with kaminari
class PaginatingDecorator < Draper::CollectionDecorator
  delegate :current_page, :total_pages, :limit_value
end
