require 'test_helper'

class RegistrationTest < ActiveSupport::TestCase
  should belong_to(:student)
  should belong_to(:camp)
  should have_one(:family).through(:student)
  
  should validate_numericality_of(:camp_id).only_integer.is_greater_than(0)
  should validate_numericality_of(:student_id).only_integer.is_greater_than(0)
  
  context "context" do
    setup do 
      create_family_users
      create_families
      create_students
      create_curriculums
      create_locations
      create_camps
      create_registrations
    end
    
    # teardown do
    #   delete_family_users
    #   delete_families
    #   delete_students
    #   delete_curriculums
    #   delete_locations
    #   delete_camps
    #   delete_registrations
    # end
    
    should "show that the student is active in the system" do
      create_inactive_students
      bad_registration = FactoryBot.build(:registration, student: @fatma, camp: @camp1)
      deny bad_registration.valid?
      delete_inactive_students
    end
    
    should "have an alphabetical scope" do
      assert_equal ["AlMaadeed, Maryam", "Alhaj, Amna", "Alsheeb, Fatma", "Phelps, Daniel"], Registration.alphabetical.all.map{|r| r.student.name}
    end
    
    should "have an for_camp scope" do
      assert_equal [@amna_r, @dan_r], Registration.for_camp(@camp1).sort_by{|r| r.student.last_name}
    end

    should "verify that the camp is active in the system" do
      bad_ex = FactoryBot.build(:registration, student: @dan, camp: @camp3)
      deny bad_ex.valid?
    end
    
  end

end
