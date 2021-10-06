class User < ApplicationRecord
	validates :email, presence:true
	validates :password_digest, presence:true
	has_many :posts
	has_secure_password
end
