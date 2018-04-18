class Family < ApplicationRecord
    #relationships
    belongs_to :user
    has_many :students
    has_many :registrations, through: :students
    
    #scopes
    scope :alphabetical, -> { order('family_name') }
    
end
