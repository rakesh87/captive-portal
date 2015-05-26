require 'rails_helper'

RSpec.describe "site_roles/edit", :type => :view do
  before(:each) do
    @site_role = assign(:site_role, SiteRole.create!(
      :name => "MyString"
    ))
  end

  it "renders the edit site_role form" do
    render

    assert_select "form[action=?][method=?]", site_role_path(@site_role), "post" do

      assert_select "input#site_role_name[name=?]", "site_role[name]"
    end
  end
end
