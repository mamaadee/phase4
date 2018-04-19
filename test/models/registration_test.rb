require 'test_helper'

class RegistrationTest < ActiveSupport::TestCase
  #relationships
  should belong_to(:student)
  should belong_to(:camp)
  should have_one(:family).through(:student)
  #validations
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
    
    #students active
    should "show that the student is active in the system" do
      create_inactive_students
      bad_registration = FactoryBot.build(:registration, student: @fatma, camp: @camp1)
      deny bad_registration.valid?
      delete_inactive_students
    end
    
    #alphabetical order
    should "have an alphabetical order" do
      assert_equal ["AlMaadeed, Maryam", "Alhaj, Amna", "Alsheeb, Fatma", "Phelps, Daniel"], Registration.alphabetical.all.map{|r| r.student.name}
    end
    
    #for camp scope
    should "for_camp scope" do
      assert_equal [@amna_r, @dan_r], Registration.for_camp(@camp1).sort_by{|r| r.student.last_name}
    end

    #camp active
    should "verify that the camp is active in the system" do
      bad_ex = FactoryBot.build(:registration, student: @dan, camp: @camp3)
      deny bad_ex.valid?
    end
    
    #different types of cards
    should "show different types of credit cards" do
      assert @maryam_r.valid?
      cards = {4324424564313=>"VISA", 5453256782464678=>"MC", 6546267534365435=>"DISC", 31234567890124=>"DCCB", 353535796442353=>"AMEX"}
      cards.each do |car, name|
      @maryam_r.credit_card_number = car
      assert_equal name, @maryam_r.credit_card_type, "#{@maryam_r.credit_card_type} :: #{@maryam_r.credit_card_number}"
      end
    end
    
    #differntiate between the valid and invalid expiration dates
    should "valid or invalid expiration dates" do
      assert @maryam_r.valid?
      @maryam_r.credit_card_number = "4324424564313"
      @maryam_r.expiration_month = Date.current.month
      @maryam_r.expiration_year = 1.year.ago.year
      deny @maryam_r.valid?
      @maryam_r.expiration_year = Date.current.year
      assert @maryam_r.valid?
      @maryam_r.expiration_month = Date.current.month - 1
      deny @maryam_r.valid?
      @maryam_r.expiration_month = Date.current.month + 1
      assert @maryam_r.valid?
    end
    
  end

end
