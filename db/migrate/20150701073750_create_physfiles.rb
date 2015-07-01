class CreatePhysfiles < ActiveRecord::Migration
  def change
    create_table :physfiles do |p|
      p.integer :frag_num
    end
  end
end
