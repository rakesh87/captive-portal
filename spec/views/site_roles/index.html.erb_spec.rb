require 'rails_helper'

RSpec.describe "site_roles/index", :type => :view do
  before(:each) do
    assign(:site_roles, [
      SiteRole.create!(
        :name => "Name"
      ),
      SiteRole.create!(
        :name => "Name"
      )
    ])
  end

  it "renders a list of site_roles" do
    render
    assert_select "tr>td", :text => "Name".to_s, :count => 2
  end
end
