require 'rails_helper'

RSpec.describe "friendships/edit", type: :view do
  before(:each) do
    @friendship = assign(:friendship, Friendship.create!(
      :friend_a_id => 1,
      :friend_b_id => 1
    ))
  end

  it "renders the edit friendship form" do
    render

    assert_select "form[action=?][method=?]", friendship_path(@friendship), "post" do

      assert_select "input[name=?]", "friendship[friend_a_id]"

      assert_select "input[name=?]", "friendship[friend_b_id]"
    end
  end
end
