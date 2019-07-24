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

  def schedule_delete_modal_params
    { confirm: 'Deleting this schedule will also permanently delete all associated historical ' \
               'payments. Are you sure you want to delete this schedule?',
      commit: 'Delete Schedule' }
  end
end
