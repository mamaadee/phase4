class Student < ApplicationRecord
    # callbacks
    before_save :set_rating_to_zero
    before_update :remove_upcoming_registrations_if_inactive
  
    #relationships
    belongs_to :family
    has_many :registrations
    has_many :camps, through: :registrations
    
    #scopes
    scope :alphabetical, -> {order('last_name, first_name')}
    scope :active, -> {where(active: true)}
    scope :inactive, -> {where(active: false)}
    scope :below_rating, ->(ceiling) {where('rating < ?', ceiling)}
    scope :at_or_above_rating, ->(floor) {where('rating >= ?', floor)}
    
    #methods
    def name
        "#{self.last_name}, #{self.first_name}"
    end

    def proper_name
        "#{self.first_name} #{self.last_name}"
    end
    
    def set_rating_to_zero
        self.rating ||= 0
    end
    
    def remove_upcoming_registrations
        return true if self.registrations.empty?
        upcoming_reg = self.registrations.select{|r| r.camp.start_date >= Date.current}
        upcoming_reg.each{ |reg| reg.destroy }
    end
    
    def remove_upcoming_registrations_if_inactive
        remove_upcoming_registrations if !self.active 
    end
end
