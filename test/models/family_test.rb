require 'test_helper'

class FamilyTest < ActiveSupport::TestCase
  should belong_to(:user)
  should have_many(:students)
  should have_many(:registrations).through(:students)
  
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
    
  end

end
