require 'rails_helper'

RSpec.describe "/inventories", type: :request do
  let(:user) { create(:user) }
  let(:manufacturer) { create(:manufacturer) }
  let(:os_name) { create(:os_name) }
  let(:model) { create(:model, manufacturer_id: manufacturer.id, os_name_id: os_name.id) }
  let(:body_color) { create(:body_color) }
  let(:memory) { create(:memory) }

  describe "POST /create" do
    before do
      sign_in user
    end

    context "with valid parameters" do
      it "creates a new inventory" do
        expect do
          inventory = {
            model: { name: { '0': model.name } },
            body_color: { name: { '0': 'Space Grey' } },
            memory: { display_name: { '0': '128GB' }, amount: { '0': 128 } },
            os_version: { major: { '0': 10 }, minor: { '0': 1 }, patch: { '0': 3 } },
            inventory: { quantity: { '0': 10 }, price: { '0': 200 } },
          }
          post inventories_url, params: inventory
        end.to change(Inventory, :count).by(1)
      end

      it "creates a new inventory with exists foreign key" do
        expect do
          inventory_with_exists_foreign_key = {
            model: { name: { '0': model.name } },
            body_color: { name: { '0': body_color.name } },
            memory: { display_name: { '0': memory.display_name }, amount: { '0': memory.amount } },
            os_version: { major: { '0': 10 }, minor: { '0': 1 }, patch: { '0': 3 } },
            inventory: { quantity: { '0': 10 }, price: { '0': 200 } },
          }
          post inventories_url, params: inventory_with_exists_foreign_key
        end.to change(BodyColor, :count).by(1)
      end

      it "creates new inventories" do
        expect do
          inventories = {
            model: { name: { '0': model.name, '1': model.name } },
            body_color: { name: { '0': body_color.name, '1': body_color.name } },
            memory: { display_name: { '0': memory.display_name, '1': memory.display_name }, amount: { '0': memory.amount, '1': memory.amount } }, # rubocop:disable Layout/LineLength
            os_version: { major: { '0': 10, '1': 10 }, minor: { '0': 1, '1': 2 }, patch: { '0': 3, '1': 4 } },
            inventory: { quantity: { '0': 10, '1': 20 }, price: { '0': 200, '1': 300 } },
          }
          post inventories_url, params: inventories
        end.to change(Inventory, :count).by(2)
      end
    end

    context "with invalid parameters" do
      it "creates a new inventory with not existed model" do
        expect do
          inventory = {
            model: { name: { '0': 999 } },
            body_color: { name: { '0': 'Space Grey' } },
            memory: { display_name: { '0': '128GB' }, amount: { '0': 128 } },
            os_version: { major: { '0': 10 }, minor: { '0': 1 }, patch: { '0': 3 } },
            inventory: { quantity: { '0': 10 }, price: { '0': 200 } },
          }
          post inventories_url, params: inventory
        end.to change(Inventory, :count).by(0)
        expect(response).to have_http_status(:internal_server_error)
      end
    end
  end
end
