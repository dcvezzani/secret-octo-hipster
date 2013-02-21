require 'spec_helper'

describe JointChild do
  before do
    @joint_child = JointChild.new
  end

  it "can belong to a settlor" do
    lambda{@joint_child.settlor_parent}.should_not raise_error
  end

  it "can belong to a spouse" do
    lambda{@joint_child.spouse_parent}.should_not raise_error
  end

  describe "basic info" do
    it "can have special needs" do
      lambda{@joint_child.has_special_needs}.should_not raise_error
    end

    it "is living or deceased" do
      lambda{@joint_child.alive}.should_not raise_error
    end
  end

  describe "clean up for joint_child" do
    before(:each) do
      @joint_child = FactoryGirl.create(:joint_child)
    end

    it "should cascade delete residential address" do
      ResidentialAddress.joins{children}.count.should > 0
      @joint_child.destroy
      ResidentialAddress.count.should == 0
    end

    it "should cascade delete mailing address" do
      MailingAddress.joins{children}.count.should > 0
      @joint_child.destroy
      MailingAddress.count.should == 0
    end
  end

end

