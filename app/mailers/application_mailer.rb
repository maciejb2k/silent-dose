class ApplicationMailer < ActionMailer::Base
  default from: ENV.fetch("SMTP_DEFAULT_FROM", "no-reply@silentdose.com")
  layout "mailer"
end
