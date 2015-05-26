require 'rails_helper'

RSpec.describe "sites/new", :type => :view do
  before(:each) do
    assign(:site, Site.new(
      :name => "MyString"
    ))
  end

  it "renders new site form" do
    render

    assert_select "form[action=?][method=?]", sites_path, "post" do

      assert_select "input#site_name[name=?]", "site[name]"
    end
  end
end
