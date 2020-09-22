require 'rails_helper'

RSpec.describe "os_names/index", type: :view do
  before do
    assign(:os_names, [
             OsName.create!,
             OsName.create!,
           ])
  end

  it "renders a list of os_names" do
    render
  end
end
