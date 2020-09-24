require 'rails_helper'

RSpec.describe "/inventories", type: :request do
  let(:user) { create(:user) }
  let(:manufacturer) { create(:manufacturer) }
  let(:os_name) { create(:os_name) }
  let(:model) { create(:model, manufacturer_id: manufacturer.id, os_name_id: os_name.id) }
  let(:body_color) { create(:body_color) }

  let(:inventory_with_exists_foreign_key) {{
    model: { name: { '0': model.name } },
    body_color: { name: { '0': body_color.name } },
    memory: { display_name: { '0': '128GB' }, amount: { '0': 128 } },
    os_version: { major: { '0': 10 }, minor: { '0': 1 }, patch: { '0': 3 } },
    inventory: { quantity: { '0': 10 }, price: { '0': 200 } }
  }}

  let(:invalid_attributes) do
    skip("Add a hash of attributes invalid for your model")
  end

  describe "POST /create" do
    context "with valid parameters" do
      it "creates a new Inventory with exists foreign key" do
        sign_in user

        expect do
          post inventories_url, params: inventory_with_exists_foreign_key
        end.to change(Inventory, :count).by(1)
      end
    end
  end
end
