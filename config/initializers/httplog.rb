# Configure HttpLog to capture the detail we want to know.

HttpLog.configure do |config|

  # Enable or disable all logging
  config.enabled = true

  # You can assign a different logger
  config.logger = Logger.new($stdout)

  # I really wouldn't change this...
  config.severity = Logger::Severity::DEBUG

  # Tweak which parts of the HTTP cycle to log...
  config.log_connect   = true
  config.log_request   = true
  config.log_headers   = true
  config.log_data      = true
  config.log_response  = false
end
