class Database < ActiveRecord::Migration
	def change
		create_table :virfiles do |v|
			v.integer :fa
			v.string :name
			v.string :path
			v.integer :phys_id
			v.boolean :visible
			v.date :update_time
		end
		create_table :physfiles do |p|
			p.integer :frag_num
		end
		create_table :fragfiles do |f|
			f.string :addr
			f.integer :phys_id
			f.integer :index		
		end
		create_table :users do |u|
			u.string :name
			u.string :password
			u.date :register_date
			u.integer :root_id
		end
	end
end
