require 'rails_helper'

RSpec.describe "os_names/edit", type: :view do
  before(:each) do
    @os_name = assign(:os_name, OsName.create!())
  end

  it "renders the edit os_name form" do
    render

    assert_select "form[action=?][method=?]", os_name_path(@os_name), "post" do
    end
  end
end
