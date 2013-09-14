require "spec_helper"

describe ProxiesController do
  describe "routing" do

    it "routes to #index" do
      get("/proxies/examples").should route_to("proxies#index", table_name: 'examples')
    end

    it "routes to #new" do
      get("/proxies/examples/new").should route_to("proxies#new", table_name: 'examples')
    end

    it "routes to #show" do
      get("/proxies/examples/1").should route_to("proxies#show", :id => "1", table_name: 'examples')
    end

    it "routes to #edit" do
      get("/proxies/examples/1/edit").should route_to("proxies#edit", :id => "1", table_name: 'examples')
    end

    it "routes to #create" do
      post("/proxies/examples").should route_to("proxies#create", table_name: 'examples')
    end

    it "routes to #update" do
      put("/proxies/examples/1").should route_to("proxies#update", :id => "1", table_name: 'examples')
      patch("/proxies/examples/1").should route_to("proxies#update", :id => "1", table_name: 'examples')
    end

    it "routes to #destroy" do
      delete("/proxies/examples/1").should route_to("proxies#destroy", :id => "1", table_name: 'examples')
    end

  end
end
