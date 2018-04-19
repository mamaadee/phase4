class User < ApplicationRecord
    #include Activator
    #callbacks
    before_save :reformat_phone
    has_secure_password
    #validations
    validates :username, presence: true, uniqueness: {case_sensitive: false}
    validates :email, presence: true, uniqueness: {case_sensitive: false}
    validates_format_of :email, with: /\A[\w]([^@\s,;]+)@(([\w-]+\.)+(com|edu|org|net|gov|mil))\z/i, message: "This is not an email format"
    validates_length_of :password, minimum: 4, message: "At least 4 characters", allow_blank: true
    validates_format_of :phone, with: /\A\(?\d{3}\)?[-. ]?\d{3}[-.]?\d{4}\z/, message: "should be 10 digits"
    
    ROLES = [['Admin', :admin],['Instructor', :instructor],['Parent', :parent]]

    def role?(authorized_role)
        return false if role.nil?
        role.downcase.to_sym == authorized_role
    end
  
    #methods
    def reformat_phone
        self.phone = self.phone.to_s.gsub(/[^0-9]/,"")
    end
end
