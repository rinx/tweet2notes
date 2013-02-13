desc "This task is called by the Heroku scheduler add-on"

task :create_notes => :environment do

  puts "create_notes start..."

  User.find(:all).each do |usr|

    Twitter.configure do |config|
      config.consumer_key = ENV['TW_CONSUMER_KEY']
      config.consumer_secret = ENV['TW_CONSUMER_SECRET']
      config.oauth_token = usr[:tw_token]
      config.oauth_token_secret = usr[:tw_secret]
    end

    enClient = EvernoteOAuth::Client.new(token: usr[:en_token])
    note_store = enClient.note_store

    tweets = ""

    yesterday = Date.today.yesterday

    Twitter.user_timeline(Twitter.user, {:count => 200}).each do |tl|

      if ( yesterday.year == tl.created_at.year &&
           yesterday.month == tl.created_at.month &&
           yesterday.day == tl.created_at.day ) then
        tweets += "@" + tl.user.screen_name + " "
        tweets += tl.created_at.strftime("[%y/%m/%d %H:%M:%S]") + "<br/>"
        tweets += tl.text + "<br/>"
        tweets += "via " + tl.source + "<br/><br/>"
      end

    end

    note = Evernote::EDAM::Type::Note.new
    note.title = "@" + Twitter.user_timeline(Twitter.user).first.user.screen_name + "'s tweets " + yesterday.strftime("%y/%m/%d")

    contentHeader = '<?xml version="1.0" encoding="UTF-8"?><!DOCTYPE en-note SYSTEM "http://xml.evernote.com/pub/enml2.dtd"><en-note>'
    contentFooter = '</en-note>'

    note.content = contentHeader.force_encoding('ASCII-8BIT') + tweets.force_encoding('ASCII-8BIT') + contentFooter.force_encoding('ASCII-8BIT')

#    note.tagNames = [usr[:tag_names]]

    note_store.createNote(note)

  end

  puts "create_notes done."

end


