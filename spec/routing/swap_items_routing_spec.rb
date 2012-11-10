require "spec_helper"

describe SwapItemsController do
  describe "routing" do

    it "routes to #index" do
      get("/swap_items").should route_to("swap_items#index")
    end

    it "routes to #new" do
      get("/swap_items/new").should route_to("swap_items#new")
    end

    it "routes to #show" do
      get("/swap_items/1").should route_to("swap_items#show", :id => "1")
    end

    it "routes to #edit" do
      get("/swap_items/1/edit").should route_to("swap_items#edit", :id => "1")
    end

    it "routes to #create" do
      post("/swap_items").should route_to("swap_items#create")
    end

    it "routes to #update" do
      put("/swap_items/1").should route_to("swap_items#update", :id => "1")
    end

    it "routes to #destroy" do
      delete("/swap_items/1").should route_to("swap_items#destroy", :id => "1")
    end

  end
end
