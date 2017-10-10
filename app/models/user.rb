class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  has_many :wikis, dependent: :destroy
  has_many :collaborators
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable, :confirmable

  enum role:[:standard, :premium, :admin]
  after_initialize {self.role ||= :standard}

  def downgrade
  	self.update_attribute(:role, 'standard')
  end

end
