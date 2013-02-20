require 'spec_helper'

describe ResidentialAddress do
  before do
    @residential_address = ResidentialAddress.new
  end

  it "should have a settlor" do
    lambda{@residential_address.settlor}.should_not raise_error
  end
  it "should have a spouse" do
    lambda{@residential_address.spouse}.should_not raise_error
  end
  it "should have children" do
    lambda{@residential_address.children}.should_not raise_error
  end

  it "should be able to assign a settlor" do
    settlor = Settlor.create
    lambda{@residential_address.settlor = settlor}.should_not raise_error
  end
end

