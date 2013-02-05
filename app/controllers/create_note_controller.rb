class CreateNoteController < ApplicationController
  def create

    Twitter.configure do |config|
      config.oauth_token = session[:twtoken]
      config.oauth_token_secret = session[:twsecret]
    end

    enClient = EvernoteOAuth::Client.new(token: session[:entoken])
    note_store = enClient.note_store

    tweets = ""

    Twitter.user_timeline(Twitter.user).each do |tl|
      tweets += "@" + tl.user.screen_name + " "
      tweets += tl.created_at.strftime("[%y/%m/%d %H:%M:%S]") + "<br/>"
      tweets += tl.text + "<br/>"
      tweets += "via " + tl.source + "<br/><br/>"
    end

    note = Evernote::EDAM::Type::Note.new
    note.title = "@" + Twitter.user_timeline(Twitter.user).first.user.screen_name + "'s tweets " + Twitter.user_timeline(Twitter.user).first.created_at.strftime("%y/%m/%d")

    contentHeader = '<?xml version="1.0" encoding="UTF-8"?><!DOCTYPE en-note SYSTEM "http://xml.evernote.com/pub/enml2.dtd"><en-note>'
    contentFooter = '</en-note>'

    note.content = contentHeader.force_encoding('ASCII-8BIT') + tweets.force_encoding('ASCII-8BIT') + contentFooter.force_encoding('ASCII-8BIT')

    note.tagNames = ['tweet2notes']

    note_store.createNote(note)

    redirect_to '/'

  end
end
