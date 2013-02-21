require 'spec_helper'

describe Address do
  before do
    @address = Address.new
  end

  it "should have a street address (line 1)" do
    lambda{@address.address_01}.should_not raise_error
  end

  it "should have a street address (line 2)" do
    lambda{@address.address_02}.should_not raise_error
  end

  it "should have a city" do
    lambda{@address.city}.should_not raise_error
  end

  it "should have a state" do
    lambda{@address.state}.should_not raise_error
  end

  it "should have a zip code" do
    lambda{@address.zip}.should_not raise_error
  end
end
