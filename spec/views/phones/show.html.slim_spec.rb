require 'rails_helper'

RSpec.describe "phones/show", type: :view do
  before do
    @phone = assign(:phone, Phone.create!)
  end

  it "renders attributes in <p>" do
    render
  end
end
