class Registration < ApplicationRecord
    #relationships
    belongs_to :camp
    belongs_to :student
    has_one :family, through: :student
end
