require 'spec_helper'

describe Settlor do
  before do
    @settlor = Settlor.new
  end

  it "should have 0 or 1 spouse" do
    lambda{@settlor.spouse}.should_not raise_error
  end

  it "should have 0 or more children" do
    lambda{@settlor.children}.should_not raise_error
  end

  describe "basic info" do
    it "should include us citizenship" do
      lambda{@settlor.us_citizen}.should_not raise_error
    end

    it "should include marital status" do
      lambda{@settlor.marital_status}.should_not raise_error
    end
  end

  describe "clean up for settlor" do
    before(:each) do
      @settlor = FactoryGirl.create(:settlor)
    end

    it "should cascade delete aliases" do
      Alias.joins{settlor}.count.should == @settlor.aliases.count
      @settlor.destroy
      Alias.count.should == 0
    end

    it "should cascade delete children" do
      Child.joins{settlor_parent}.count.should == @settlor.children.count
      @settlor.destroy
      Child.count.should == 0
    end

    it "should cascade delete spouse" do
      if(Spouse.count > 0)
        Spouse.count.should == 1
        Spouse.first.should == @settlor.spouse
      end

      @settlor.destroy
      Spouse.count.should == 0
    end

    it "should cascade delete residential address" do
      ResidentialAddress.joins{settlor}.count.should > 0
      @settlor.destroy
      ResidentialAddress.count.should == 0
    end

    it "should cascade delete mailing address" do
      MailingAddress.joins{settlor}.count.should > 0
      @settlor.destroy
      MailingAddress.count.should == 0
    end
  end

  describe "simple test" do
    before(:each) do
      @settlor = Settlor.create
      @settlor.spouse = Spouse.create
      @settlor.children << Child.create
      @settlor.children << Child.create
      @settlor.children << Child.create
      @settlor.children << Child.create

      @settlor.update_attributes(residential_address: ResidentialAddress.create)
      @settlor.spouse.update_attributes(residential_address: @settlor.residential_address)
      @settlor.children.each{|x| x.update_attributes(residential_address: @settlor.residential_address)}

      @settlor.update_attributes(mailing_address: MailingAddress.create)
      @settlor.spouse.update_attributes(mailing_address: @settlor.mailing_address)
      @settlor.children.each{|x| x.update_attributes(mailing_address: @settlor.mailing_address)}

      @settlor.aliases << Alias.create(value: "aaa")
      @settlor.aliases << Alias.create
      @settlor.aliases << Alias.create

      @settlor.spouse.aliases << Alias.create(value: "bbb")
      @settlor.spouse.aliases << Alias.create

      @settlor = Settlor.first
      @spouse = @settlor.spouse
      @child = @settlor.children.first
    end

    describe "the residential address" do
      it "should be used for everyone (only one exists)" do
        ResidentialAddress.count.should == 1
      end

      it "should have a settlor" do
        ResidentialAddress.first.tenants.should include_tenant(@settlor)
      end

      it "should have a spouse" do
        ResidentialAddress.first.tenants.should include_tenant(@spouse)
      end

      it "should have at least one child" do
        ResidentialAddress.first.tenants.should include_tenant(@child)
      end

      it "should have 4 children" do
        ResidentialAddress.first.tenants.should have_children_count(4)
      end
    end

    describe "the mailing address" do
      it "should be used for everyone (only one exists)" do
        MailingAddress.count.should == 1
      end

      it "should have a settlor" do
        MailingAddress.first.recipients.should include_recipient(@settlor)
      end

      it "should have a spouse" do
        MailingAddress.first.recipients.should include_recipient(@spouse)
      end

      it "should have at least one child" do
        MailingAddress.first.recipients.should include_recipient(@child)
      end

      it "should have 4 children" do
        MailingAddress.first.recipients.should have_children_count(4)
      end
    end

    describe "aliases" do
      it "should exist for settlor" do
        @settlor.aliases.should have_items_count(3)
      end

      it "should have alias for settlor" do
        @settlor.aliases.should have_item_with(:value, "aaa")
      end

      it "should exist for spouse" do
        @spouse.aliases.should have_items_count(2)
      end

      it "should have alias for spouse" do
        @spouse.aliases.should have_item_with(:value, "bbb")
      end
    end
  end

  describe "factories" do
    before(:all) do
      @current_time = Time.now
      @settlors = FactoryGirl.create_list(:settlor, 25)
    end

    after(:all) do
      Settlor.destroy_all(["id in (?)", @settlors.map(&:id)])
    end

    it "should have more settlors than spouses, statistically speaking" do
      Settlor.should have_more_entries_than(Spouse)#.after(@current_time)
    end

    it "should have more residential addresses than settlors, but not more than 100" do
      ResidentialAddress.should have_more_entries_than(25)
      ResidentialAddress.should have_less_entries_than(100)
    end

    it "should have more mailing addresses than settlors, but not more than 100" do
      MailingAddress.should have_more_entries_than(25)#.after(@current_time)
      MailingAddress.should have_less_entries_than(100)#.after(@current_time)
    end
  end
  
end
