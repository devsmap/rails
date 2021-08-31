namespace :api do
  instance_eval(File.read(Rails.root.join("config/routes/api/versions/v1.rb")))
end
