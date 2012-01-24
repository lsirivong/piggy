# Load the rails application
require File.expand_path('../application', __FILE__)

# Initialize the rails application
Piggy::Application.initialize!

Piggy::Application.configure do
  config.action_mailer.default_url_options = { :host => ENV['PIGGY_MAILER_DEFAULT_HOST'] || "0.0.0.0:3000" }

  config.action_mailer.smtp_settings = {
    :address => "smtp.gmail.com",
    :port => 587,
    :domain => ENV['PIGGY_MAILER_DEFAULT_HOST'] || "0.0.0.0:3000",
    :authentication => "plain",
    :user_name => ENV['PIGGY_MAILER_SMTP_USERNAME'] || "username",
    :password => ENV['PIGGY_MAILER_SMTP_PASSWORD'] || "secret",
    :enable_starttls_auto => true,
  }
end
