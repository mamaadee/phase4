class Family < ApplicationRecord
    #callbacks
    before_save :set_rating_to_zero
    
    #relationships
    belongs_to :user
    has_many :students
    has_many :registrations, through: :students
    
    #scopes
    scope :alphabetical, -> {order('family_name')}
    scope :active, -> { where(active: true) }
    scope :inactive, -> { where(active: false) }
    
    #validation
    validates_presence_of :family_name, :parent_first_name
    
    #methods
    def set_rating_to_zero
        rating ||= 0
    end
    
end
