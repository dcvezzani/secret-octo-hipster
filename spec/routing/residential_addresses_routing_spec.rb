require "spec_helper"

describe ResidentialAddressesController do
  describe "routing" do

    it "routes to #index" do
      get("/residential_addresses").should route_to("residential_addresses#index")
    end

    it "routes to #new" do
      get("/residential_addresses/new").should route_to("residential_addresses#new")
    end

    it "routes to #show" do
      get("/residential_addresses/1").should route_to("residential_addresses#show", :id => "1")
    end

    it "routes to #edit" do
      get("/residential_addresses/1/edit").should route_to("residential_addresses#edit", :id => "1")
    end

    it "routes to #create" do
      post("/residential_addresses").should route_to("residential_addresses#create")
    end

    it "routes to #update" do
      put("/residential_addresses/1").should route_to("residential_addresses#update", :id => "1")
    end

    it "routes to #destroy" do
      delete("/residential_addresses/1").should route_to("residential_addresses#destroy", :id => "1")
    end

  end
end
