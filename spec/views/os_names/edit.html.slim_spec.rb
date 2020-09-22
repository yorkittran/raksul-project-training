require 'rails_helper'

RSpec.describe "os_names/edit", type: :view do
  let(:os_name) { OsName.create! }

  it "renders the edit os_name form" do
    render

    assert_select "form[action=?][method=?]", os_name_path(os_name), "post" do
    end
  end
end
