require 'rails_helper'

RSpec.describe "manufacturers/edit", type: :view do
  let(:manufacturer) { Manufacturer.create! }

  it "renders the edit manufacturer form" do
    render

    assert_select "form[action=?][method=?]", manufacturer_path(manufacturer), "post" do
    end
  end
end
