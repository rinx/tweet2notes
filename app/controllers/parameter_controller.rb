class ParameterController < ApplicationController
  def input

    if (session[:twtoken] == nil) or 
       (session[:twsecret] == nil) or
       (session[:entoken] == nil) then

      redirect_to root_url, :notice => "please login both!!"

    end

  end

  def register
    
    User.create(:tw_token => session[:twtoken], 
                :tw_secret => session[:twsecret],
                :en_token => session[:entoken],
                :notebook => params[:notebook_name],
                :tags => params[:tag_names],
                :updated_at => Time.now)
                
    redirect_to root_url, :notice => 'your token is registered!!'

  end
end
