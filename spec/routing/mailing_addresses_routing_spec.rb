require "spec_helper"

describe MailingAddressesController do
  describe "routing" do

    it "routes to #index" do
      get("/mailing_addresses").should route_to("mailing_addresses#index")
    end

    it "routes to #new" do
      get("/mailing_addresses/new").should route_to("mailing_addresses#new")
    end

    it "routes to #show" do
      get("/mailing_addresses/1").should route_to("mailing_addresses#show", :id => "1")
    end

    it "routes to #edit" do
      get("/mailing_addresses/1/edit").should route_to("mailing_addresses#edit", :id => "1")
    end

    it "routes to #create" do
      post("/mailing_addresses").should route_to("mailing_addresses#create")
    end

    it "routes to #update" do
      put("/mailing_addresses/1").should route_to("mailing_addresses#update", :id => "1")
    end

    it "routes to #destroy" do
      delete("/mailing_addresses/1").should route_to("mailing_addresses#destroy", :id => "1")
    end

  end
end
