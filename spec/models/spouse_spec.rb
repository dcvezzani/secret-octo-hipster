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
end

