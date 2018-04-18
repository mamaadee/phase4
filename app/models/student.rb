class Student < ApplicationRecord
    #relationships
    belongs_to :family
    has_many :registrations
    has_many :camps, through: :registrations
end
