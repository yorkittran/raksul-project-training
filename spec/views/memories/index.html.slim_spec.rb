require 'rails_helper'

RSpec.describe "memories/index", type: :view do
  before do
    assign(:memories, [
             Memory.create!,
             Memory.create!,
           ])
  end

  it "renders a list of memories" do
    render
  end
end
