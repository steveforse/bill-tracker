# frozen_string_literal: true

# This is how mail is sent
class ApplicationMailer < ActionMailer::Base
  default from: 'from@example.com'
  layout 'mailer'
end
