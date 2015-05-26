require 'rails_helper'

RSpec.describe "sites/show", :type => :view do
  before(:each) do
    @site = assign(:site, Site.create!(
      :name => "Name"
    ))
  end

  it "renders attributes in <p>" do
    render
    expect(rendered).to match(/Name/)
  end
end
