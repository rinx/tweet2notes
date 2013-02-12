class User < ActiveRecord::Base
  attr_accessible :en_secret, :notebook, :tags, :tw_secret, :tw_token, :updated_at
end
