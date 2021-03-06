require 'rails_helper'

RSpec.describe '/inventories', type: :request do
  let(:body_color) { create(:body_color) }
  let(:manufacturer) { create(:manufacturer) }
  let(:memory) { create(:memory) }
  let(:model) { create(:model, manufacturer_id: manufacturer.id, os_name_id: os_name.id) }
  let(:os_name) { create(:os_name) }
  let(:os_version) { create(:os_version) }
  let(:user) { create(:user) }
  let(:phone) { create(:phone, body_color: body_color, memory: memory, os_version: os_version, model: model, user: user) }
  let(:inventory) { create(:inventory, phone: phone) }

  before do
    sign_in user
  end

  describe 'GET /inventories' do
    it do
      get inventories_url
      expect(response).to have_http_status(:ok)
    end
  end

  describe 'GET /inventories/new' do
    it do
      get new_inventory_url
      expect(response).to have_http_status(:ok)
    end
  end

  describe 'DELETE /inventory/x' do
    it do
      delete inventory_url(id: inventory.id, model_id: model.id)
      expect(response).to redirect_to model_url(id: model.id)
    end
  end

  describe 'PUT /inventory/x/restore' do
    it do
      put restore_inventory_url(id: inventory.id, model_id: model.id)
      expect(response).to redirect_to model_url(id: model.id)
    end
  end

  describe 'POST /create' do
    context 'with valid parameters' do
      it 'creates a new inventory' do
        inventory = {
          model: { '0': model.id },
          body_color: { '0': body_color.id },
          memory: { '0': memory.id },
          os_version: { '0': '14.1.3' },
          quantity: { '0': 10 },
          price: { '0': 200 },
        }
        post inventories_url, params: inventory
        expect(response).to redirect_to inventories_path
      end

      it 'creates a new inventory with exists foreign key' do
        inventory_with_exists_foreign_key = {
          model: { '0': model.id },
          body_color: { '0': body_color.id },
          memory: { '0': memory.id },
          os_version: { '0': '14.1.3' },
          quantity: { '0': 10 },
          price: { '0': 200 },
        }
        post inventories_url, params: inventory_with_exists_foreign_key
        expect(response).to redirect_to inventories_path
      end

      it 'creates new inventories' do
        inventories = {
          model: { '0': model.id, '1': model.id },
          body_color: { '0': body_color.id, '1': body_color.id },
          memory: { '0': memory.id, '1': memory.id },
          os_version: { '0': '14.1.3', '1': '10.1.3' },
          quantity: { '0': 10, '1': 20 },
          price: { '0': 200, '1': 300 },
        }
        post inventories_url, params: inventories
        expect(response).to redirect_to inventories_path
      end
    end

    context 'with invalid parameters' do
      it do
        post inventories_url, params: {}
        expect(response).to have_http_status(:internal_server_error)
      end
    end
  end
end
