require 'test_helper'

class UserTest < ActiveSupport::TestCase
  #validations
  should validate_presence_of(:username)
  should validate_presence_of(:email)
  should have_secure_password
  should allow_value("mamaadee@qatar.cmu.edu").for(:email)
  should allow_value("mamaadee@mmfm.com").for(:email)
  should_not allow_value("alex").for(:email)
  should_not allow_value("maama@mmfm,com").for(:email)
  should allow_value("5734667476").for(:phone)
  should allow_value("999-299-9999").for(:phone)
  should_not allow_value("669843").for(:phone)
  should_not allow_value("456783653t6").for(:phone)
  
  context "context" do
    setup do
      create_users
    end
    
    # teardown do
    #   delete_users
    # end
    
    should " with passwords" do
      assert @maryam_u.authenticate("secret")
      deny @maryam_u.authenticate("notsecret")
    end
    
    #unique usernames
    should "users should have unique usernames" do
      assert_equal "mamaadee", @maryam_u.username
      @maryam_u.username = "AMNAAZZ"
      deny @maryam_u.valid?, "#{@maryam_u.username}"
    end
    
    #to require a password
    should "require a password" do
      bad_user = FactoryBot.build(:user, username: "ahmad", password: nil)
      deny bad_user.valid?
    end
    
  end
end
