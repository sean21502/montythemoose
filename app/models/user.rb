class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable, :confirmable

  USER_ROLES = {
    :standard => 10,
    :premium => 0
  }
  
  def set_as_premium 
  	self.role = USER_ROLES[:premium]
	end

	def set_as_standard 
  	self.role = USER_ROLES[:standard]
	end

	def can_edit?(wiki)
  	true if owns?(wiki) || premium?
	end

	def can_destroy?(wiki)
  	true if owns?(wiki) || premium?
	end

	def owns?(wiki)
  	true if self.id == wiki.user_id
	end

	def premium?
  	true if self.role_name == :premium
	end

	def role_name
  	User.user_roles.key(self.role)
	end

	def self.user_roles
  	USER_ROLES
	end
end
