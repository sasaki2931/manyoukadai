class User < ApplicationRecord
    before_validation { email.downcase! }
    has_many :tasks
    validates :name, presence: true
    validates :email, presence: true
    has_secure_password
    validates :password, length: { minimum: 6 }
end
