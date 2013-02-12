class ParameterController < ApplicationController
  def input

    if (session[:twtoken] == nil) or 
       (session[:twsecret] == nil) or
       (session[:entoken] == nil) then

      redirect_to root_url, :notice => "please login both!!"

    end

  end

  def register
  end
end
