class User < ApplicationRecord
    #callbacks
    before_save :reformat_phone
    has_secure_password
    #validations
    validates :username, presence: true, uniqueness: {case_sensitive: false}
    validates :email, presence: true, uniqueness: {case_sensitive: false}
    validates_format_of :email, with: /\A[\w]([^@\s,;]+)@(([\w-]+\.)+(com|edu|org|net|gov|mil))\z/i, message: "This is not an email format"
    validates_length_of :password, minimum: 4, message: "At least 4 characters", allow_blank: true
    validates_format_of :phone, with: /\A\(?\d{3}\)?[-. ]?\d{3}[-.]?\d{4}\z/, message: "should be 10 digits"
end
