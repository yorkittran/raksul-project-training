require 'rails_helper'

RSpec.describe "memories/edit", type: :view do
  before(:each) do
    @memory = assign(:memory, Memory.create!())
  end

  it "renders the edit memory form" do
    render

    assert_select "form[action=?][method=?]", memory_path(@memory), "post" do
    end
  end
end
