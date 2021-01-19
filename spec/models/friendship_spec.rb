require 'rails_helper'

RSpec.describe Friendship, type: :model do
  let(:alan) { Member.create(name: 'Alan', url: 'http://www.alanswebsite.com') }
  let(:bart) { Member.create(name: 'Bart', url: 'http://www.bartswebsite.com') }
  context "Validation" do
    it "is valid with valid attributes" do
      friendship = Friendship.new(friend_a_id: alan.id, friend_b_id: bart.id)
      expect(friendship).to be_valid
    end
    it "is not valid without a friend_b_id" do
      friendship = Friendship.new(friend_a_id: alan.id, friend_b_id: nil)
      expect(friendship).to_not be_valid
    end
    it "is not valid without a friend_a_id" do
      friendship = Friendship.new(friend_a_id: nil, friend_b_id: bart.id)
      expect(friendship).to_not be_valid
    end
  end
end
