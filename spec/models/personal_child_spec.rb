require 'spec_helper'

describe PersonalChild do
  before do
    @personal_child = JointChild.new
  end

  it "can belong to a settlor" do
    lambda{@personal_child.settlor_parent}.should_not raise_error
  end

  it "can belong to a spouse" do
    lambda{@personal_child.spouse_parent}.should_not raise_error
  end

  describe "basic info" do
    it "can have special needs" do
      lambda{@personal_child.has_special_needs}.should_not raise_error
    end

    it "is living or deceased" do
      lambda{@personal_child.alive}.should_not raise_error
    end
  end

  describe "clean up for personal_child" do
    before(:each) do
      @personal_child = FactoryGirl.create(:personal_child)
    end

    it "should cascade delete residential address" do
      ResidentialAddress.joins{children}.count.should > 0
      @personal_child.destroy
      ResidentialAddress.count.should == 0
    end

    it "should cascade delete mailing address" do
      MailingAddress.joins{children}.count.should > 0
      @personal_child.destroy
      MailingAddress.count.should == 0
    end
  end

end

