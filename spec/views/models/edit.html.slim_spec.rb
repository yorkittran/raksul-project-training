require 'rails_helper'

RSpec.describe "models/edit", type: :view do
  let(:model) { Model.create! }

  it "renders the edit model form" do
    render

    assert_select "form[action=?][method=?]", model_path(model), "post" do
    end
  end
end
