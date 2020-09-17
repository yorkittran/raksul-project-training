require "rails_helper"

RSpec.describe OsNamesController, type: :routing do
  describe "routing" do
    it "routes to #index" do
      expect(get: "/os_names").to route_to("os_names#index")
    end

    it "routes to #new" do
      expect(get: "/os_names/new").to route_to("os_names#new")
    end

    it "routes to #show" do
      expect(get: "/os_names/1").to route_to("os_names#show", id: "1")
    end

    it "routes to #edit" do
      expect(get: "/os_names/1/edit").to route_to("os_names#edit", id: "1")
    end


    it "routes to #create" do
      expect(post: "/os_names").to route_to("os_names#create")
    end

    it "routes to #update via PUT" do
      expect(put: "/os_names/1").to route_to("os_names#update", id: "1")
    end

    it "routes to #update via PATCH" do
      expect(patch: "/os_names/1").to route_to("os_names#update", id: "1")
    end

    it "routes to #destroy" do
      expect(delete: "/os_names/1").to route_to("os_names#destroy", id: "1")
    end
  end
end
