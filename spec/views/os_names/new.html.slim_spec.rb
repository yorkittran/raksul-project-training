require 'rails_helper'

RSpec.describe "os_names/new", type: :view do
  before do
    assign(:os_name, OsName.new)
  end

  it "renders new os_name form" do
    render

    assert_select "form[action=?][method=?]", os_names_path, "post" do
    end
  end
end
