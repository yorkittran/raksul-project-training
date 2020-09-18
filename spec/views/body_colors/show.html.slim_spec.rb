require 'rails_helper'

RSpec.describe "body_colors/show", type: :view do
  before(:each) do
    @body_color = assign(:body_color, BodyColor.create!())
  end

  it "renders attributes in <p>" do
    render
  end
end
