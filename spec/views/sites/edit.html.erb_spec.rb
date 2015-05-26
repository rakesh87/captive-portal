require 'rails_helper'

RSpec.describe "sites/edit", :type => :view do
  before(:each) do
    @site = assign(:site, Site.create!(
      :name => "MyString"
    ))
  end

  it "renders the edit site form" do
    render

    assert_select "form[action=?][method=?]", site_path(@site), "post" do

      assert_select "input#site_name[name=?]", "site[name]"
    end
  end
end
