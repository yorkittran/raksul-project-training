 require 'rails_helper'

# This spec was generated by rspec-rails when you ran the scaffold generator.
# It demonstrates how one might use RSpec to test the controller code that
# was generated by Rails when you ran the scaffold generator.
#
# It assumes that the implementation code is generated by the rails scaffold
# generator. If you are using any extension libraries to generate different
# controller code, this generated spec may or may not pass.
#
# It only uses APIs available in rails and/or rspec-rails. There are a number
# of tools you can use to make these specs even more expressive, but we're
# sticking to rails and rspec-rails APIs to keep things simple and stable.

RSpec.describe "/body_colors", type: :request do
  # BodyColor. As you add validations to BodyColor, be sure to
  # adjust the attributes here as well.
  let(:valid_attributes) {
    skip("Add a hash of attributes valid for your model")
  }

  let(:invalid_attributes) {
    skip("Add a hash of attributes invalid for your model")
  }

  describe "GET /index" do
    it "renders a successful response" do
      BodyColor.create! valid_attributes
      get body_colors_url
      expect(response).to be_successful
    end
  end

  describe "GET /show" do
    it "renders a successful response" do
      body_color = BodyColor.create! valid_attributes
      get body_color_url(body_color)
      expect(response).to be_successful
    end
  end

  describe "GET /new" do
    it "renders a successful response" do
      get new_body_color_url
      expect(response).to be_successful
    end
  end

  describe "GET /edit" do
    it "render a successful response" do
      body_color = BodyColor.create! valid_attributes
      get edit_body_color_url(body_color)
      expect(response).to be_successful
    end
  end

  describe "POST /create" do
    context "with valid parameters" do
      it "creates a new BodyColor" do
        expect {
          post body_colors_url, params: { body_color: valid_attributes }
        }.to change(BodyColor, :count).by(1)
      end

      it "redirects to the created body_color" do
        post body_colors_url, params: { body_color: valid_attributes }
        expect(response).to redirect_to(body_color_url(BodyColor.last))
      end
    end

    context "with invalid parameters" do
      it "does not create a new BodyColor" do
        expect {
          post body_colors_url, params: { body_color: invalid_attributes }
        }.to change(BodyColor, :count).by(0)
      end

      it "renders a successful response (i.e. to display the 'new' template)" do
        post body_colors_url, params: { body_color: invalid_attributes }
        expect(response).to be_successful
      end
    end
  end

  describe "PATCH /update" do
    context "with valid parameters" do
      let(:new_attributes) {
        skip("Add a hash of attributes valid for your model")
      }

      it "updates the requested body_color" do
        body_color = BodyColor.create! valid_attributes
        patch body_color_url(body_color), params: { body_color: new_attributes }
        body_color.reload
        skip("Add assertions for updated state")
      end

      it "redirects to the body_color" do
        body_color = BodyColor.create! valid_attributes
        patch body_color_url(body_color), params: { body_color: new_attributes }
        body_color.reload
        expect(response).to redirect_to(body_color_url(body_color))
      end
    end

    context "with invalid parameters" do
      it "renders a successful response (i.e. to display the 'edit' template)" do
        body_color = BodyColor.create! valid_attributes
        patch body_color_url(body_color), params: { body_color: invalid_attributes }
        expect(response).to be_successful
      end
    end
  end

  describe "DELETE /destroy" do
    it "destroys the requested body_color" do
      body_color = BodyColor.create! valid_attributes
      expect {
        delete body_color_url(body_color)
      }.to change(BodyColor, :count).by(-1)
    end

    it "redirects to the body_colors list" do
      body_color = BodyColor.create! valid_attributes
      delete body_color_url(body_color)
      expect(response).to redirect_to(body_colors_url)
    end
  end
end