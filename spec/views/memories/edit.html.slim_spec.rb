require 'rails_helper'

RSpec.describe "memories/edit", type: :view do
  let(:memory) { Memory.create! }

  it "renders the edit memory form" do
    render

    assert_select "form[action=?][method=?]", memory_path(memory), "post" do
    end
  end
end
