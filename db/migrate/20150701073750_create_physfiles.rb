class CreatePhysfiles < ActiveRecord::Migration
  def change
    create_table :physfiles do |t|

      t.timestamps null: false
    end
  end
end
