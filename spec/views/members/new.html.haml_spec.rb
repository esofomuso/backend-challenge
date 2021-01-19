require 'rails_helper'

RSpec.describe "members/new", type: :view do
  before(:each) do
    assign(:member, Member.new(
      :name => "MyString",
      :url => "MyString",
      :short_url => "MyString"
    ))
  end

  xit "renders new member form" do
    render

    assert_select "form[action=?][method=?]", members_path, "post" do

      assert_select "input[name=?]", "member[name]"

      assert_select "input[name=?]", "member[url]"

      assert_select "input[name=?]", "member[short_url]"
    end
  end
end
