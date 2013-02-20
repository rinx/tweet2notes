class AddTweetToUsers < ActiveRecord::Migration
  def change
    add_column :users, :tweet, :bit
  end
end
