load 'virfile.rb'
class User < ActiveRecord::Base
    attr_readonly :id, :name, :register_date, :root_id;

    class << self
	def login(name = '', password = '')
		user = User.find_by(name: name, password: password)
		if user == nil
			return false
		else 
			return true
		end
	end
	# |name| < 3 return -1
	# |psw|  < 6 return -2
	# user exist return -3
	def register(name = '', psw = '')
		if name.length < 3
			return -1
		elsif	psw.length < 6
			return -2
		else 
			exuser = User.find_by(name: name)
			if exuser != nil
				return -3
			end
			
			file = Virfile.create(fa: 0, name: name, path: '', phys_id: -1, visible: true, update_time: Time.now)
			user = User.create(name: name, password: psw, register_date: Time.now, root_id: file.id)
			return user
		end
	end
	def newpsw(name = '', old_psw = '', new_psw = '')
		if new_psw.length < 6
			return false
		else 
			user = User.find_by(name: name, password: old_psw)
			if user == nil
				return false
			end
			user.password = new_psw
			user.save
			return true
		end
	end
    end

	# use a specific user-object to call the api. (***.generate_token)
	def generate_token ()
		while(1)
			self.authen_token = SecureRandom.base64(64)
			break if User.find_by(authen_token: authen_token) == nil
		end
		self.save
		return authen_token
	end

	def auth_token(client_token = '')
		if self.authen_token == client_token
			return true
		else
			return false
		end	
	end

end
