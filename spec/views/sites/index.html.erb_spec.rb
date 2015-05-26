require 'rails_helper'

RSpec.describe "sites/index", :type => :view do
  before(:each) do
    assign(:sites, [
      Site.create!(
        :name => "Name"
      ),
      Site.create!(
        :name => "Name"
      )
    ])
  end

  it "renders a list of sites" do
    render
    assert_select "tr>td", :text => "Name".to_s, :count => 2
  end
end
