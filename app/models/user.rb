class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable, :confirmable

  enum role:[:standard, :premium, :admin]
  after_initialize {self.role ||= :standard}

  def downgrade
  	self.update_attribute(:role, 'standard')
  end

end
