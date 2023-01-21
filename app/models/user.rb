class User < ApplicationRecord
    before_validation { email.downcase! }
    has_many :tasks
    validates :name, presence: true
    validates :email, presence: true
    has_secure_password
    validates :password, length: { minimum: 6 }

    before_update :admin_cannot_update
    before_destroy :admin_cannot_delete


    private

    def admin_cannot_update
        throw :abort if User.exists?(admin: true) && self.saved_change_to_admin == [true, false]
    end

    def admin_cannot_delete
        throw :abort if User.exists?(admin: true) && self.admin == true
    end
end
