class CreateVirfiles < ActiveRecord::Migration
  def change
    create_table :virfiles do |v|
      v.integer :fa
      v.string :name
      v.string :path
      v.integer :phys_id
      v.boolean :visible
      v.date :update_time
    end
  end
end
