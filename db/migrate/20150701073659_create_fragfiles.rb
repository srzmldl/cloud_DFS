class CreateFragfiles < ActiveRecord::Migration
  def change
    create_table :fragfiles do |t|

      t.timestamps null: false
    end
  end
end
