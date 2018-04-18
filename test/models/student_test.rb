require 'test_helper'

class StudentTest < ActiveSupport::TestCase
  should belong_to(:family)
  should have_many(:registrations)
  should have_many(:camps).through(:registrations)
  
  should validate_presence_of(:first_name)
  should validate_presence_of(:last_name)
  should validate_presence_of(:family_id)
  
  should allow_value(12.years.ago.to_date).for(:date_of_birth)
  should allow_value(7.years.ago.to_date).for(:date_of_birth)
  
  should_not allow_value(Date.today).for(:date_of_birth)
  should_not allow_value(1.day.from_now.to_date).for(:date_of_birth)

end
