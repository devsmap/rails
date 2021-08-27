config_file = File.join(Rails.root.to_s, '/config/action_mailer.yml')
if Rails.env.development? || Rails.env.test?
  DockerRails::Application.config.action_mailer.delivery_method = :smtp
  DockerRails::Application.config.action_mailer.default_url_options = { host: 'devsmap.local' }
  DockerRails::Application.config.action_mailer.asset_host = 'devsmap.local'
  DockerRails::Application.config.action_mailer.smtp_settings = { address: 'mailcatcher', port: 1025, domain: 'devsmap.local' }
end

if Rails.env.production?
  DockerRails::Application.config.action_mailer.delivery_method = :postmark

  DockerRails::Application.config.action_mailer.postmark_settings = {
    api_token: Rails.application.credentials.postmark_api_token
  } 
end
