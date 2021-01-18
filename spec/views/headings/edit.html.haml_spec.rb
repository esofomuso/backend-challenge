require 'rails_helper'

RSpec.describe "headings/edit", type: :view do
  before(:each) do
    @heading = assign(:heading, Heading.create!(
      :member_id => 1,
      :kind => "MyString",
      :name => "MyString"
    ))
  end

  it "renders the edit heading form" do
    render

    assert_select "form[action=?][method=?]", heading_path(@heading), "post" do

      assert_select "input[name=?]", "heading[member_id]"

      assert_select "input[name=?]", "heading[kind]"

      assert_select "input[name=?]", "heading[name]"
    end
  end
end
