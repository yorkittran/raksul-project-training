require 'rails_helper'

RSpec.describe "phones/edit", type: :view do
  let(:phone) { Phone.create! }

  it "renders the edit phone form" do
    render

    assert_select "form[action=?][method=?]", phone_path(phone), "post" do
    end
  end
end
