class CreateFragfiles < ActiveRecord::Migration
  def change
    create_table :fragfiles do |f|
      f.string :addr
      f.integer :phys_id		
    end
  end
end