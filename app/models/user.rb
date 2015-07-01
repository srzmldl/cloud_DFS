require './app/models/virfile'
class User < ActiveRecord::Base
	def login(name = '', password = '')
		user = User.find_by(name: name, password: password)
		if user == nil
			return false
		else 
			return true
		end
	end
	#|name| < 3 return -1
	#|psw|  < 6 return -2
	def register(name = '', psw = '')
		if name.length < 3
			return -1
		elsif	psw.length < 6
			return -2
		else 
			user = User.create(name: name, password: psw, register_date: Time.now)
			return user
		end
	end
	#root: root directory file (virtual)
	#this method is used to modify the root_id
	#father of root file must id_0
	def redirect(name = '', root = '')
		user = User.find_by(name: name)
		if user == nil
			return false
		else 
			file = Virfile.new
			file = file.find_by_path(root)
			if file	== nil or file.fa != 0 or file.visible == false
				return false
			else
				user.root_id = file.id
				user.save
				return true
			end
		end
	end

	def newpsw(name = '', psw = '')
		if psw.length < 6
			return false
		else 
			user = User.find_by(name: name)
			if user == nil
				return false
			end
			user.password = psw
			user.save
			return true
		end
	end
end
