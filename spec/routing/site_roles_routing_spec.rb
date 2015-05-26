require "rails_helper"

RSpec.describe SiteRolesController, :type => :routing do
  describe "routing" do

    it "routes to #index" do
      expect(:get => "/site_roles").to route_to("site_roles#index")
    end

    it "routes to #new" do
      expect(:get => "/site_roles/new").to route_to("site_roles#new")
    end

    it "routes to #show" do
      expect(:get => "/site_roles/1").to route_to("site_roles#show", :id => "1")
    end

    it "routes to #edit" do
      expect(:get => "/site_roles/1/edit").to route_to("site_roles#edit", :id => "1")
    end

    it "routes to #create" do
      expect(:post => "/site_roles").to route_to("site_roles#create")
    end

    it "routes to #update" do
      expect(:put => "/site_roles/1").to route_to("site_roles#update", :id => "1")
    end

    it "routes to #destroy" do
      expect(:delete => "/site_roles/1").to route_to("site_roles#destroy", :id => "1")
    end

  end
end
