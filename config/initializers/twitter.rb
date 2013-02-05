twconfig = YAML.load(ERB.new(File.read('config/twitter.yml')).result)[Rails.env]

Twitter.configure do |config|
  config.consumer_key = twconfig['consumer_key']
  config.consumer_secret = twconfig['consumer_secret']
end

