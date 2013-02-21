require 'spec_helper'

describe Spouse do
  before do
    @spouse = Spouse.new
  end

  it "should have 1 settlor" do
    lambda{@spouse.settlor}.should_not raise_error
  end

  it "should have 0 or more children" do
    lambda{@spouse.children}.should_not raise_error
  end

  describe "basic info" do
    it "should include us citizenship" do
    lambda{@spouse.us_citizen}.should_not raise_error
    end

    it "should include marital status" do
    lambda{@spouse.marital_status}.should_not raise_error
    end
  end

  describe "clean up for spouse" do
    before(:each) do
      @spouse = FactoryGirl.create(:spouse)
    end

    it "should cascade delete aliases" do
      Alias.joins{spouse}.count.should == @spouse.aliases.count
      @spouse.destroy
      Alias.count.should == 0
    end

    it "should cascade delete children" do
      Child.joins{spouse_parent}.count.should == @spouse.children.count
      @spouse.destroy
      Child.count.should == 0
    end

    it "should cascade delete residential address" do
      ResidentialAddress.joins{spouse}.count.should > 0
      @spouse.destroy
      ResidentialAddress.count.should == 0
    end

    it "should cascade delete mailing address" do
      MailingAddress.joins{spouse}.count.should > 0
      @spouse.destroy
      MailingAddress.count.should == 0
    end
  end

end

