class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :nick, {:limit => 512, :null => false}
      t.string :onick, {:limit => 500, :null => false}
      t.text :password, {:limit => 90, :null => false}
      t.string :email, {:limit => 512, :null => false, :primary_key => true}
      t.text :activatekey, {:limit => 32, :null => false}
      t.boolean :active, :null => false
      t.datetime :loginrecent
      t.datetime :loginfirst
      t.datetime :created
    end

    add_index :users, :password, :unique => true
    add_index :users, :nick, :unique => true
    add_index :users, :email, :unique => true
    add_index :users, :onick
    add_index :users, :active
  end
end
