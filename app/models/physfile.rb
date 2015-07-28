class Physfile < ActiveRecord::Base
    attr_readonly :id;
    class << self
	def creat(num = 0, file_sha1 = '', file_md5 = '')
		file = Physfile.create(frag_num: num, sha1: file_sha1, md5: file_md5)
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
			file.save
			return true
		end
	end
    end
end
