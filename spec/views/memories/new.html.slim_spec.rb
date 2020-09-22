require 'rails_helper'

RSpec.describe "memories/new", type: :view do
  before do
    assign(:memory, Memory.new)
  end

  it "renders new memory form" do
    render

    assert_select "form[action=?][method=?]", memories_path, "post" do
    end
  end
end
