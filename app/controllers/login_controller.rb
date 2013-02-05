class LoginController < ApplicationController
  def twCallback
    session[:twtoken] = request.env['omniauth.auth']['credentials']['token']
    session[:twsecret] = request.env['omniauth.auth']['credentials']['secret']

    redirect_to root_url, :notice => "Twitter signed in!"
  end

  def enCallback
    session[:entoken] = request.env['omniauth.auth']['credentials']['token']

    redirect_to root_url, :notice => "Evernote signed in!"
  end

  def twLogout
    session[:twtoken] = nil
    session[:twsecret] = nil

    redirect_to root_url, :notice => "Twitter signed out!"
  end

  def enLogout
    session[:entoken] = nil

    redirect_to root_url, :notice => "Evernote signed out!"
  end
end
