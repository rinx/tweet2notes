class LoginController < ApplicationController
  def twCallback
    session[:twtoken] = request.env['omniauth.auth']['credentials']['token']
    session[:twsecret] = request.env['omniauth.auth']['credentials']['secret']

    redirect_to '/'
  end

  def enCallback
    session[:entoken] = request.env['omniauth.auth']['credentials']['token']

    redirect_to '/'
  end

  def twLogout
    session[:twtoken] = nil
    session[:twsecret] = nil

    redirect_to '/'
  end

  def enLogout
    session[:entoken] = nil

    redirect_to '/'
  end
end
