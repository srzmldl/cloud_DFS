load 'physfile.rb'
class Fragfile < ActiveRecord::Base
    class << self
	def creat(phys_id = -1, addr = '', index = -1, md5 = '', sha1 = '', server_name = '')
		#if physical-file is non-exist, return false
		phys = Physfile.find_id(phys_id)
		if(phys == nil or index < 0)
			return false
		end

		file = Fragfile.create(phys_id: phys_id, addr: addr, index: index, md5: md5, sha1: sha1, server_name: server_name)
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
			file.save
			return true
		end	
	end
    end
end
