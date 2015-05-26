require 'rails_helper'

RSpec.describe User, :type => :model do

  before (:each) do
  	role = FactoryGirl.create(:admin_role)
  	role = FactoryGirl.create(:role)
    @user1 = FactoryGirl.create(:user, email: "user1@ue.com")
    @user1.add_role 'admin'
    @user2 = FactoryGirl.create(:user, email: "user2@ue.com")
  end

  describe ".admin?" do
    context "user is having properties" do
      pending "return false if user is not the Admin" do
      	raise @user2.has_role?(:admin).inspect
        expect(@user1.has_role?(:admin)).to be_true
      end
    end
    context "user is not having properties" do
      pending "return true if user is the Admin" do
      	raise @user2.has_role?(:admin).inspect

        expect(@user2.has_role?(:admin)).to be_true
      end
    end
  end

end

