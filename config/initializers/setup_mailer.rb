ActionMailer::Base.delivery_method = :smtp
ActionMailer::Base.smtp_settings = {
:address => "smtp.gmail.com",
:port => 587,
domain: "fitcasts.com",
  authentication: "plain",
  enable_starttls_auto: true,
  user_name: "alexzotov@fitcasts.com",
  password: "Yulianna2"
}