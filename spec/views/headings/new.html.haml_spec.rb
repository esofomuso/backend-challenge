require 'rails_helper'

RSpec.describe "headings/new", type: :view do
  before(:each) do
    assign(:heading, Heading.new(
      :member_id => 1,
      :kind => "MyString",
      :name => "MyString"
    ))
  end

  it "renders new heading form" do
    render

    assert_select "form[action=?][method=?]", headings_path, "post" do

      assert_select "input[name=?]", "heading[member_id]"

      assert_select "input[name=?]", "heading[kind]"

      assert_select "input[name=?]", "heading[name]"
    end
  end
end
