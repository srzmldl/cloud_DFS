class Virfile < ActiveRecord::Base
    class << self
	def list(path = '')
		fa = find_by_path(path)
		if fa == nil
			fa = 0
		else 
			fa = fa.id
		end
		
		files = Virfile.where(fa: fa).order('name')
		a = []
		files.each do |f|
			a.push(f)		
		end
		return a
	end
    
	def creat(path = '', name = 'New', physid = -1)
		fa = find_by_path(path)
		if fa == nil
			fa = 0	
		else 
			fa = fa.id
		end
		
		#if the file name collapse, return 1
		exfile = Virfile.find_by(fa: fa, name: name)
		if(exfile != nil)
			return 1
		end

		file = Virfile.new
		file.fa = fa
		file.name = name
		file.path = path
		file.phys_id = physid
		file.visible = true
		file.update_time = Time.now

		file.save
		return file
	end
	def delete(id = -1)
		file = Virfile.find_by(id: id)
		if file == nil		
			return nil
		else
			file.visible = false
			file.save
			return file
		end
	end
	def find_by_path(path = 'Home')
		cur = 0;
		buf = ""
		i = 0
		while i < path.length
			buf = ""
			while path[i] != '/' and i < path.length
				buf = buf + path[i]
				i = i + 1			
			end
			i = i + 1
			cur = Virfile.find_by(fa: cur, name: buf)
			if cur == nil
				return nil		
			end
			file = cur
			cur = cur.id
		end
		return file
	end
    end
end
