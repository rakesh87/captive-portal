require 'rails_helper'

RSpec.describe "site_roles/new", :type => :view do
  before(:each) do
    assign(:site_role, SiteRole.new(
      :name => "MyString"
    ))
  end

  it "renders new site_role form" do
    render

    assert_select "form[action=?][method=?]", site_roles_path, "post" do

      assert_select "input#site_role_name[name=?]", "site_role[name]"
    end
  end
end
