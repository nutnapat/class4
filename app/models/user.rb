class User < ApplicationRecord
	validates :email, presence:true
	validates :pass, presence:true
	has_many :posts
end
