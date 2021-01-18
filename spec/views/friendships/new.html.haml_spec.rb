require 'rails_helper'

RSpec.describe "friendships/new", type: :view do
  before(:each) do
    assign(:friendship, Friendship.new(
      :friend_a_id => 1,
      :friend_b_id => 1
    ))
  end

  it "renders new friendship form" do
    render

    assert_select "form[action=?][method=?]", friendships_path, "post" do

      assert_select "input[name=?]", "friendship[friend_a_id]"

      assert_select "input[name=?]", "friendship[friend_b_id]"
    end
  end
end
