require 'rails_helper'

RSpec.describe CreateBulkService do
  describe 'call' do
    let(:body_color) { create(:body_color) }
    let(:manufacturer) { create(:manufacturer) }
    let(:memory) { create(:memory) }
    let(:model) { create(:model, manufacturer: manufacturer, os_name: os_name) }
    let(:os_name) { create(:os_name) }
    let(:os_version) { create(:os_version) }
    let(:user) { create(:user) }

    let(:valid_element) { {
      model: model,
      body_color: body_color,
      memory: memory,
      os_version: os_version,
      inventory: Inventory.new(quantity: 10, price: 200)
    } }

    let(:valid_element_2) { {
      model: model,
      body_color: body_color,
      memory: memory,
      os_version: os_version,
      inventory: Inventory.new(quantity: 20, price: 300)
    } }

    context 'successfully create' do
      it 'one inventory' do
        expect do
          params = [valid_element]
          CreateBulkService.call(params, user)
        end.to change(Inventory, :count).by(1)
      end

      it 'many inventory' do
        expect do
          params = [valid_element, valid_element_2]
          CreateBulkService.call(params, user)
        end.to change(Inventory, :count).by(2)
      end
    end
  end
end
