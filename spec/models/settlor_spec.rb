require 'spec_helper'

describe Settlor do
  before do
    @client = Settlor.new
  end

  it "should have 0 or 1 spouse" do
    lambda{@client.spouse}.should_not raise_error
  end
end
