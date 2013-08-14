class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :token_authenticatable, :confirmable,
  # :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
  has_many :activities, :dependent => :destroy
  has_one :profile, :dependent => :destroy
  # Setup accessible (or protected) attributes for your model
  attr_accessible :username, :email, :password, :password_confirmation, :time_zone
  # attr_accessible :title, :body
  has_many :albums, :dependent => :destroy
  validates_presence_of :username
  validates_uniqueness_of :username
 
end
