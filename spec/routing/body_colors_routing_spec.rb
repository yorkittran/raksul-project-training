require "rails_helper"

RSpec.describe BodyColorsController, type: :routing do
  describe "routing" do
    it "routes to #index" do
      expect(get: "/body_colors").to route_to("body_colors#index")
    end

    it "routes to #new" do
      expect(get: "/body_colors/new").to route_to("body_colors#new")
    end

    it "routes to #show" do
      expect(get: "/body_colors/1").to route_to("body_colors#show", id: "1")
    end

    it "routes to #edit" do
      expect(get: "/body_colors/1/edit").to route_to("body_colors#edit", id: "1")
    end

    it "routes to #create" do
      expect(post: "/body_colors").to route_to("body_colors#create")
    end

    it "routes to #update via PUT" do
      expect(put: "/body_colors/1").to route_to("body_colors#update", id: "1")
    end

    it "routes to #update via PATCH" do
      expect(patch: "/body_colors/1").to route_to("body_colors#update", id: "1")
    end

    it "routes to #destroy" do
      expect(delete: "/body_colors/1").to route_to("body_colors#destroy", id: "1")
    end
  end
end
