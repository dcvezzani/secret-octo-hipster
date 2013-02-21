require 'spec_helper'

describe Child do
  before do
    @child = Child.new
  end

  it "can belong to a settlor" do
    lambda{@child.settlor_parent}.should_not raise_error
  end

  it "can belong to a spouse" do
    lambda{@child.spouse_parent}.should_not raise_error
  end

  describe "basic info" do
    it "can have special needs" do
      lambda{@child.has_special_needs}.should_not raise_error
    end

    it "is living or deceased" do
      lambda{@child.alive}.should_not raise_error
    end
  end

  describe "clean up for child" do
    before(:each) do
      @child = FactoryGirl.create(:child)
    end

    it "should cascade delete residential address" do
      ResidentialAddress.joins{children}.count.should > 0
      @child.destroy
      ResidentialAddress.count.should == 0
    end

    it "should cascade delete mailing address" do
      MailingAddress.joins{children}.count.should > 0
      @child.destroy
      MailingAddress.count.should == 0
    end
  end

end
