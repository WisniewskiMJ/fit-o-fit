class ApplicationMailer < ActionMailer::Base
  default from: 'noreply@herokuapp.com'
  layout 'mailer'
end
