class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :authentification
      t.string :nick
      t.string :email
      t.string :activatekey
      t.boolean :active
      t.datetime :firstlogin
      t.datetime :lastlogin

      t.timestamps
    end
  end
end
