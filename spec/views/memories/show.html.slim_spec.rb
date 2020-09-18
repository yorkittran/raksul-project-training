require 'rails_helper'

RSpec.describe "memories/show", type: :view do
  before(:each) do
    @memory = assign(:memory, Memory.create!())
  end

  it "renders attributes in <p>" do
    render
  end
end
