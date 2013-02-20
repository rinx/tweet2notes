class AddTweetingToUsers < ActiveRecord::Migration
  def change
    add_column :users, :tweeting, :bit
  end
end
