require 'spec_helper'

describe Alias do
  before do
    @alias = Alias.new
  end

  it "should have a value" do
    lambda{@alias.value}.should_not raise_error
  end

  it "belongs to a client" do
    lambda{@alias.client}.should_not raise_error
  end

  it "can belong to a settlor" do
    lambda{@alias.settlor}.should_not raise_error
  end

  it "can belong to a spouse" do
    lambda{@alias.spouse}.should_not raise_error
  end
end
