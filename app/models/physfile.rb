class Physfile < ActiveRecord::Base
	def creat(num = 0)
		file = Physfile.create(frag_num: num)
		return file
	end	

	def find_id(id = -1)
		file = Physfile.find_by(id: id)
		return file
	end

	def modify(id = -1, num = 0)
		file = Physfile.find_by(id: id)
		if file == nil
			return false
		else
			file.frag_num = num
			return true
		end	
	end
end