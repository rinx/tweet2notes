class User < ActiveRecord::Base
  attr_accessible :en_token, :notebook, :tags, :tw_secret, :tw_token, :tweeting, :updated_at
end
