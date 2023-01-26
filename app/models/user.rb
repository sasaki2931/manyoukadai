class User < ApplicationRecord
    before_validation { email.downcase! }
    has_many :tasks, dependent: :destroy
    validates :name, presence: true
    validates :email, presence: true
    has_secure_password
    validates :password, length: { minimum: 6 }

    before_update :admin_cannot_update
    before_destroy :admin_cannot_delete


    private

    def admin_cannot_update
        @admin_users = User.where(admin: true)
      if(@admin_users.count == 1 && @admin_users.first == self) && self.admin == false
        throw.abort
      end
    end
        

    def admin_cannot_delete
        if User.where(admin:true).count == 1 && self.admin
            throw :abort
        end
    end        
    
end
