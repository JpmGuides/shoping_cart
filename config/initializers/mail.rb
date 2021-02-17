ActionMailer::Base.default({
  from: "information@jpmguides.com"
})

ActionMailer::Base.smtp_settings = {
  :address        => "asmtp.fastnet.ch",
  :port           => "587",
  :authentication => :plain,
  :user_name      => ENV["MAIL_USERNAME"],
  :password       => ENV["MAIL_PASSWORD"],
  :enable_starttls_auto => true
}
