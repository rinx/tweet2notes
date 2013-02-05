enconfig = YAML.load(ERB.new(File.read('config/evernote.yml')).result)[Rails.env]
site = enconfig['sandbox'] ? 'https://sandbox.evernote.com' : 'https://evernote.com'
twconfig = YAML.load(ERB.new(File.read('config/twitter.yml')).result)[Rails.env]

Rails.application.config.middleware.use OmniAuth::Builder do
  provider :evernote, enconfig['consumer_key'], enconfig['consumer_secret'], :client_options => {:site => site}
  provider :twitter, twconfig['consumer_key'], twconfig['consumer_secret']
end

