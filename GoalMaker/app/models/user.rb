class User < ApplicationRecord
    attr_reader :password
    validates :username, presence: true, uniqueness: true 
    validates :password, presence: true, length: { minimum: 6, allow_nil: true }
    validates :password_digest, presence: true
    validates :session_token, presence: true

    before_validation :ensure_session_token
    def password=(password)
        @password = password 
        self.password_digest = BCrypt::Password.create(password)
    end

    def reset_session_token 
        self.session_token = User.generate_session_token
        self.save! 
        self.session_token
    end 

    def is_password?(password)
        BCrypt::Password.new(self.password_digest).is_password?(password)
    end 

    def ensure_session_token 
        self.session_token ||= User.generate_session_token
    end 

    def self.find_by_credentials(username, password)
        user = User.find_by(username: username)
        return user if user && user.is_password?(password)
    end 







    private 

    def self.generate_session_token 
        SecureRandom.urlsafe_base64(16)
    end 


end
