require 'rails_helper'

RSpec.describe "body_colors/new", type: :view do
  before(:each) do
    assign(:body_color, BodyColor.new())
  end

  it "renders new body_color form" do
    render

    assert_select "form[action=?][method=?]", body_colors_path, "post" do
    end
  end
end
