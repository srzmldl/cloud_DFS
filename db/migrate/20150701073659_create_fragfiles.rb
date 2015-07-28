class CreateFragfiles < ActiveRecord::Migration
  def change
    create_table :fragfiles do |f|
      f.string :addr
      f.string :md5
      f.string :sha1
      f.string :server_name
      f.integer :phys_id
      f.integer :index
    end
  end
end
