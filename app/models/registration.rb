class Registration < ApplicationRecord
    #relationships
    belongs_to :camp
    belongs_to :student
    has_one :family, through: :student
    
    #scopes
    scope :alphabetical, -> { joins(:student).order('students.last_name, students.first_name') }
    scope :for_camp, ->(camp_id) {where(camp_id: camp_id)}
    
end
