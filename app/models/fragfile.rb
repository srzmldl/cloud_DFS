require './physfile'
class Fragfile < ActiveRecord::Base
	def creat(phys_id = -1, addr = '')
		#if physical-file is non-exist, return false
		phys = Physfile.new
		phys = phys.find_id(phys_id)
		if(phys == nil)
			return false
		end

		file = Fragfile.create(phys_id: phys_id, addr: addr)
		return file
	end	
	#find by physical-file id
	def find_all(id = -1)
		files = Fragfile.where(phys_id: id).order('addr')
		a = []
		files.each do |f|
			a.push(f)
		end
		return a
	end

	def modify(id = -1, addr = '')
		file = Fragfile.find_by(id: id)
		if file == nil
			return false
		else
			file.addr = addr
			return true
		end	
	end
end