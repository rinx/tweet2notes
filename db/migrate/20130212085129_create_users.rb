class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :tw_token
      t.string :tw_secret
      t.string :en_token
      t.string :notebook
      t.string :tags
      t.boolean :tweeting
      t.date :updated_at

      t.timestamps
    end
  end
end
