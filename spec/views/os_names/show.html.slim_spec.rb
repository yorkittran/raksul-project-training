require 'rails_helper'

RSpec.describe "os_names/show", type: :view do
  before do
    @os_name = assign(:os_name, OsName.create!)
  end

  it "renders attributes in <p>" do
    render
  end
end
