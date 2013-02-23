require "spec_helper"

describe SettlorsController do
  describe "routing" do

    it "routes to #index" do
      get("/settlors").should route_to("settlors#index")
    end

    it "routes to #new" do
      get("/settlors/new").should route_to("settlors#new")
    end

    it "routes to #show" do
      get("/settlors/1").should route_to("settlors#show", :id => "1")
    end

    it "routes to #edit" do
      get("/settlors/1/edit").should route_to("settlors#edit", :id => "1")
    end

    it "routes to #create" do
      post("/settlors").should route_to("settlors#create")
    end

    it "routes to #update" do
      put("/settlors/1").should route_to("settlors#update", :id => "1")
    end

    it "routes to #destroy" do
      delete("/settlors/1").should route_to("settlors#destroy", :id => "1")
    end

  end
end
