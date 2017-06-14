class CreateUsers < ActiveRecord::Migration[5.1]
  def change
    create_table :users do |t|
      t.string :uid
      t.string :name
      t.string :oauth_token
      t.datetime :oauth_expires_at
      t.string :token

      t.timestamps
    end

    add_index :users, :oauth_token, unique: true
    add_index :users, :token, unique: true
  end
end
