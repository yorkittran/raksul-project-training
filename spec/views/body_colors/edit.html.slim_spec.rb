require 'rails_helper'

RSpec.describe "body_colors/edit", type: :view do
  let(:body_color) { BodyColor.create! }

  it "renders the edit body_color form" do
    render

    assert_select "form[action=?][method=?]", body_color_path(body_color), "post" do
    end
  end
end
