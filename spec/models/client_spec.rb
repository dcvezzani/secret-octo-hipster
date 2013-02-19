require 'spec_helper'

describe Client do
  before do
    @client = Client.new
  end

  it "should have 0 or more aliases" do
    lambda{@client.aliases}.should_not raise_error
  end

  it "should have 0 or 1 residential address" do
    lambda{@client.residential_address}.should_not raise_error
  end

  it "should have 0 or 1 mailing address" do
    lambda{@client.mailing_address}.should_not raise_error
  end

  describe "basic info" do
    it "should include a full legal name" do
    lambda{@client.full_legal_name}.should_not raise_error
    end

    it "should include a date of birth" do
    lambda{@client.born_at}.should_not raise_error
    end

    it "should include us citizenship" do
    lambda{@client.us_citizen}.should_not raise_error
    end

    it "should include marital status" do
    lambda{@client.marital_status}.should_not raise_error
    end
  end

  describe "contact info" do
    it "should include a phone number" do
    lambda{@client.contact_phone_number}.should_not raise_error
    end

    it "should include an email address" do
    lambda{@client.contact_email_address}.should_not raise_error
    end
  end
end
