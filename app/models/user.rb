class User < ApplicationRecord
    validates :username, :password_digest, presence: true
    validates :username, uniqueness: true

    after_initialize :ensure_session_token

    def self.find_by_credentials(username_arg, password_arg)
        user =  User.find_by({username: username_arg})
        return nil if user.nil?
        should_return_user = user.is_password?(password_arg)
        if should_return_user
            return user
        else
            return nil
        end
    end

    def self.g_session_token
        SecureRandom.base64
    end
    
    def ensure_session_token
        self.session_token ||= User.g_session_token
    end

    def reset_session_token 
        self.session_token = User.g_session_token
        # session[:session_token] = self.session_token
        self.save!
        return self.session_token
    end

    def password= (password)
        @password = password
        self.password_digest = BCrypt::Password.create(password)
    end

    def is_password?(password)
        pass = BCrypt::Password.new(self.password_digest)
        pass.is_password?(password)
        # self.password_digest == pass
    end
end