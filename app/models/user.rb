class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable, :confirmable,
         :recoverable, :rememberable, :trackable, :validatable
  attr_accessible :email, :password, :password_confirmation, :role, :remember_me
  validates :email, :presence => true, :uniqueness => true
  before_create :create_role

  ROLES = %w[admin mirror banned]
  
  def admin?
    unless role.nil?
        return true if role.downcase == 'admin'
    end
    false
  end

  def mirror?
    unless role.nil?
        return true if role.downcase == 'mirror'
    end
    false
  end

  private

  def create_role
    if self.role.nil? or self.role.blank?
        self.role = 'banned'
    end
  end
end
