class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :name
      t.string :password
      t.date :register_date
      t.integer :root_id
      t.timestamps null: false
      t.string :authen_token
      t.integer :wrong_token_time
    end
  end
end
