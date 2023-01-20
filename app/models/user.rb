class User < ApplicationRecord
    before_validation { email.downcase! }
    has_many :tasks
end
