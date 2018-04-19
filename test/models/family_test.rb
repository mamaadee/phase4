require 'test_helper'

class FamilyTest < ActiveSupport::TestCase
  #relationships
  should belong_to(:user)
  should have_many(:students)
  should have_many(:registrations).through(:students)
  #validations
  should validate_presence_of(:family_name)
  should validate_presence_of(:parent_first_name)
  
  context "context" do
    setup do 
      create_family_users
      create_families
      create_inactive_families
    end
    
    # teardown do
    #   delete_families
    #   delete_inactive_families
    #   delete_family_users
    # end
    
    #alphabetical order
    should "sort families in alphabetical order" do
      assert_equal ["AlMaadeed", "Alhaj", "Alsheeb", "Phelps"], Family.alphabetical.all.map(&:family_name)
    end
    
    #family not destroyable
    should "show family is not destroyable" do
      deny @almaadeed.destroy
    end
  
    #active families
    should "show active families" do
      assert_equal 3, Family.active.size
      assert_equal ["AlMaadeed", "Alhaj", "Phelps"], Family.active.all.map(&:family_name).sort
    end
    
    #inactive families
    should "show inactive family" do
      assert_equal 1, Family.inactive.size
      assert_equal %w[Alsheeb], Family.inactive.all.map(&:family_name).sort
    end
    
    #remove registrations
    should "remove upcoming registrations" do
      create_curriculums
      create_locations
      create_camps
      create_students
      create_registrations
      assert_equal 3, @almaadeed.registrations.count
      @almaadeed.make_inactive
      @almaadeed.reload
      assert_equal 0, @almaadeed.registrations.count
      delete_registrations
      delete_students
      delete_camps
      delete_locations
      delete_curriculums
    end
    
  end

end
