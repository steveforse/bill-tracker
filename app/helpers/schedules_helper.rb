# frozen_string_literal: true

# These helpers used in views for schedules
module SchedulesHelper
  def grouped_frequencies
    [
      ['Weekly', Schedule.frequencies
                         .select { |k| k.include? 'weekly' }
                         .map { |k, v| [k, v[:description]] }],
      ['Monthly', Schedule.frequencies
                          .select { |k| k.include? 'monthly' }
                          .map { |k, v| [k, v[:description]] }],
      ['Annually', Schedule.frequencies
                           .select { |k| k.include? 'annually' }
                           .map { |k, v| [k, v[:description]] }]
    ]
  end
end
