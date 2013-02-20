require 'spec_helper'

describe MailingAddress do
  before do
    @mailing_address = MailingAddress.new
  end

  it "should have a settlor" do
    lambda{@mailing_address.settlor}.should_not raise_error
  end
  it "should have a spouse" do
    lambda{@mailing_address.spouse}.should_not raise_error
  end
  it "should have children" do
    lambda{@mailing_address.children}.should_not raise_error
  end

  it "should be able to assign a settlor" do
    settlor = Settlor.create
    lambda{@mailing_address.settlor = settlor}.should_not raise_error
  end

end
