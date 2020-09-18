require 'rails_helper'

RSpec.describe "body_colors/index", type: :view do
  before(:each) do
    assign(:body_colors, [
      BodyColor.create!(),
      BodyColor.create!()
    ])
  end

  it "renders a list of body_colors" do
    render
  end
end
