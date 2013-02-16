desc "This task is called by the Heroku scheduler add-on"

task :create_notes => :environment do

  puts "create_notes start..."

  User.find(:all).each do |usr|

    begin

      Twitter.configure do |config|
        config.consumer_key = ENV['TW_CONSUMER_KEY']
        config.consumer_secret = ENV['TW_CONSUMER_SECRET']
        config.oauth_token = usr[:tw_token]
        config.oauth_token_secret = usr[:tw_secret]
      end

      enClient = EvernoteOAuth::Client.new(token: usr[:en_token])
      note_store = enClient.note_store

      tweets = ""

      yesterdayTweetFlag= 1
      lastID = Twitter.user_timeline(Twitter.user).first.id

      yesterday = Date.today.yesterday

      while (yesterdayTweetFlag == 1) do

        i = 1

        Twitter.user_timeline(Twitter.user, {:count => 200, :max_id => lastID}).each do |tl|

          unless (i == 200) then 
            if ( yesterday.year == tl.created_at.year &&
                 yesterday.month == tl.created_at.month &&
                 yesterday.day == tl.created_at.day ) then
              tweets += "@" + tl.user.screen_name + " "
              tweets += tl.created_at.strftime("[%y/%m/%d %H:%M:%S]") + "<br/>"
              tweets += tl.text + "<br/>"
              tweets += "via " + tl.source + "<br/><br/>"
              yesterdayTweetFlag = 1
            else
              yesterdayTweetFlag = 0
            end
            i += 1
          else  
            lastID = tl.id
          end

        end

      end

      unless (tweets == "") then
        note = Evernote::EDAM::Type::Note.new
        note.title = "@" + Twitter.user_timeline(Twitter.user).first.user.screen_name + "'s tweets " + yesterday.strftime("%y/%m/%d")

        contentHeader = '<?xml version="1.0" encoding="UTF-8"?><!DOCTYPE en-note SYSTEM "http://xml.evernote.com/pub/enml2.dtd"><en-note>'
        contentFooter = '</en-note>'

        note.content = contentHeader.force_encoding('ASCII-8BIT') + tweets.force_encoding('ASCII-8BIT') + contentFooter.force_encoding('ASCII-8BIT')

        if ( usr[:notebook] != "" ) then
          notebook = note_store.listNotebooks.select {|notebook| notebook.name == usr[:notebook]}.first
          if notebook.present?
            notebook_guid = notebook.guid
          else
            notebook = Evernote::EDAM::Type::Notebook.new
            notebook.name = usr[:notebook]
            notebook_guid = note_store.createNotebook(notebook).guid
          end
          note.notebookGuid = notebook_guid
        end

        if ( usr[:tags] != "" ) then
          note.tagNames = usr[:tags].split(/\s*,\s*/)
        end

        note_store.createNote(note)
      end

      usr.touch

    rescue
      
      puts "An Error occured at the data of #{usr[:id]}"
      
    end

  end

  User.delete_all(["updated_at < ?", 7.day.ago])

  puts "create_notes done."

end


