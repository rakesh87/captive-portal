require 'rails_helper'

RSpec.describe "site_roles/show", :type => :view do
  before(:each) do
    @site_role = assign(:site_role, SiteRole.create!(
      :name => "Name"
    ))
  end

  it "renders attributes in <p>" do
    render
    expect(rendered).to match(/Name/)
  end
end
