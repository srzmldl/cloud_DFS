class CreatePhysfiles < ActiveRecord::Migration
  def change
    create_table :physfiles do |p|
      p.integer :frag_num
      p.string :sha1
      p.string :md5
    end
  end
end
