config_file = File.join(Rails.root.to_s, '/config/action_mailer.yml')

if File.exists? config_file
  if smtp_config = YAML.load_file(File.expand_path(config_file))[Rails.env]
    DockerRails::Application.config.action_mailer.delivery_method = :smtp
    DockerRails::Application.config.action_mailer.default_url_options = { host: smtp_config[:domain] }
    DockerRails::Application.config.action_mailer.asset_host = smtp_config[:domain]
    DockerRails::Application.config.action_mailer.smtp_settings = smtp_config
  end
end
