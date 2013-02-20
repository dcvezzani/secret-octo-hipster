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

  describe "simple test" do
    RSpec::Matchers.define :include_tenant do |expected_tenant|
      match do |actual_tenants|
        actual_tenants.include?(expected_tenant)
      end
    end
    RSpec::Matchers.define :include_recipient do |expected_recipient|
      match do |actual_recipients|
        actual_recipients.include?(expected_recipient)
      end
    end
    RSpec::Matchers.define :have_children_count do |expected|
      match do |tenants|
        @actual_children = tenants.select{|tenant| tenant.is_a?(Child)}.length
        expected == @actual_children
      end

      failure_message_for_should do |actual|
        "expected the number of children to be #{expected}, but there appear to be #{@actual_children} instead"
      end
    end
    RSpec::Matchers.define :have_items_count do |expected, type=nil|
      match do |actual_collection|
        type = actual_collection.first.class if(type.nil? and actual_collection.length > 0 and !actual_collection.first.nil?)
        @filtered_collection = actual_collection.select{|item| item.is_a?(type)}
        @filtered_collection.length == expected
      end

      failure_message_for_should do |actual_collection|
        "expected #{expected} #{type.name.pluralize.tableize.downcase.gsub(/_/, " ")} to be included in collection, but got #{@filtered_collection.length}"
      end
    end
    RSpec::Matchers.define :have_item_with do |attr, expected|
      match do |actual_collection|
        @actual_item = actual_collection.find{|item| item.send(attr) == expected}
        !@actual_item.nil?
      end

      failure_message_for_should do |actual_collection|
        "expected #{actual_collection} to have an item whose #{attr} has a value of '#{expected}', but found none"
      end
    end

    before(:all) do
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
    end

    describe "the residential address" do
      before(:each) do
        @settlor = Settlor.first
        @spouse = @settlor.spouse
        @child = @settlor.children.first
      end

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

      it "should have at least one child" do
        ResidentialAddress.first.tenants.should have_children_count(4)
      end
    end

    describe "the mailing address" do
      before(:each) do
        @settlor = Settlor.first
        @spouse = @settlor.spouse
        @child = @settlor.children.first
      end

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

      it "should have at least one child" do
        MailingAddress.first.recipients.should have_children_count(4)
      end
    end

    describe "aliases" do
      before(:each) do
        @settlor = Settlor.first
        @spouse = @settlor.spouse
      end

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
end
