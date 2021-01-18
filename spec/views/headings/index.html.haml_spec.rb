require 'rails_helper'

RSpec.describe "headings/index", type: :view do
  before(:each) do
    assign(:headings, [
      Heading.create!(
        :member_id => 2,
        :kind => "Kind",
        :name => "Name"
      ),
      Heading.create!(
        :member_id => 2,
        :kind => "Kind",
        :name => "Name"
      )
    ])
  end

  it "renders a list of headings" do
    render
    assert_select "tr>td", :text => 2.to_s, :count => 2
    assert_select "tr>td", :text => "Kind".to_s, :count => 2
    assert_select "tr>td", :text => "Name".to_s, :count => 2
  end
end
