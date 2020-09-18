require 'rails_helper'

RSpec.describe "body_colors/edit", type: :view do
  before(:each) do
    @body_color = assign(:body_color, BodyColor.create!())
  end

  it "renders the edit body_color form" do
    render

    assert_select "form[action=?][method=?]", body_color_path(@body_color), "post" do
    end
  end
end
