class CreateVirfiles < ActiveRecord::Migration
  def change
    create_table :virfiles do |t|

      t.timestamps null: false
    end
  end
end
