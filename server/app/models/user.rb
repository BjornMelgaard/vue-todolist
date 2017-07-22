class User < ActiveRecord::Base
  devise :database_authenticatable, :registerable, :recoverable,
         :rememberable, :trackable, :validatable, :omniauthable
         # :confirmable
  include DeviseTokenAuth::Concerns::User

  has_many :projects
  has_many :tasks,       through: :projects
  has_many :comments,    through: :tasks
  has_many :attachments, through: :comments
end
