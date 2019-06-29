module SchedulesHelper
  def grouped_frequencies
    [
      ['Weekly', Schedule.frequencies.select { |k| k.include? 'weekly'}.to_a],
      ['Monthly', Schedule.frequencies.select { |k| k.include? 'monthly'}.to_a],
      ['Annually', Schedule.frequencies.select { |k| k.include? 'annually'}.to_a]
    ]
  end
end
