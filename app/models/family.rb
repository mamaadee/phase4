class Family < ApplicationRecord
    #callbacks
    before_save :set_rating_to_zero
    before_update :handle_family_being_made_inactive
    before_destroy do 
        cannot_destroy_object()
    end
    
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
    
    def make_students_inactive
        self.students.each{|s| s.make_inactive}
    end
    
    def remove_upcoming_registrations
        self.registrations.select{|r| r.camp.start_date >= Date.current}.each{|r| r.destroy}
    end
    
    def family_being_made_inactive
        if self.active == false
            remove_upcoming_registrations
            make_students_inactive
        end
    end
    
end
