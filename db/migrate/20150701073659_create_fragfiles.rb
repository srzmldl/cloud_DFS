class CreateFragfiles < ActiveRecord::Migration
  def change
    create_table :fragfiles do |f|
      f.string :addr
      f.integer :phys_id
      f.integer :index		
    end
  end
end
