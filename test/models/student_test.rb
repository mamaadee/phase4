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
  
  context "context" do
    setup do
      create_family_users
      create_families
      create_students
    end
    
    # teardown do
    #   delete_students
    #   delete_families
    #   delete_family_users
    # end
    
    should "sort students in alphabetical order" do
      assert_equal ["AlMaadeed, Maryam", "Alhaj, Amna","Phelps, Daniel"], Student.alphabetical.all.map(&:name)
    end
    
    should "have working age method" do 
      assert_equal 11, @amna.age
      assert_equal 18, @dan.age 
    end
    
    should "show that name method works" do
      assert_equal "Alhaj, Amna", @amna.name
      assert_equal "Phelps, Daniel", @dan.name
    end
    
    should "show that proper_name method works" do
      assert_equal "Maryam AlMaadeed", @maryam.proper_name
      assert_equal "Fatma AlSheeb", @fatma.proper_name
    end
    
    should "verify that student with no rating has default set to zero" do
      create_inactive_students
      assert_equal 0, @fatma.rating
      delete_inactive_students
    end
    
    should "verify that the student's family is active in the system" do
      create_inactive_families
      maryam = FactoryBot.build(:student, family: @alsheeb, first_name: "Maryam")
      deny maryam.valid?
      delete_inactive_families
      alemadi = FactoryBot.build(:family, family_name: "Alemadi")
      rouda = FactoryBot.build(:student, family: alemadi, first_name: "Rouda")
      deny rouda.valid?
    end
    
    should "show that there are active students" do
      create_inactive_students
      assert_equal 3, Student.active.size
      assert_equal ["Maryam", "Amna", "Daniel"], Student.active.all.map(&:first_name).sort
      delete_inactive_students
    end
    
    should "show that there is one inactive student" do
      create_inactive_students
      assert_equal 1, Student.inactive.size
      assert_equal ["Fatma"], Student.inactive.all.map(&:first_name).sort
      delete_inactive_students
    end
    
    should "have working at_or_above_rating scope" do
      assert_equal 1, Student.at_or_above_rating(1500).size
      assert_equal ["Amna"], Student.at_or_above_rating(1500).all.map(&:first_name).sort      
    end
    
    should "have working below_rating scope" do |variable|
      assert_equal 2, Student.below_rating(1000).size
      assert_equal ["Daniel", "Maryam"], Student.below_rating(1000).all.map(&:first_name).sort      
    end
    
  end

end
