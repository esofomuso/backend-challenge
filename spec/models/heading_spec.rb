require 'rails_helper'

RSpec.describe Heading, type: :model do
  let(:alan) { Member.create(name: 'Alan', url: 'http://www.alanswebsite.com') }
  context "Validation" do
    it "is valid with valid attributes" do
      heading = Heading.new(member_id: alan.id, name: 'Tester', kind: "h2")
      expect(heading).to be_valid
    end
    it "is not valid without a name" do
      heading = Heading.new(member_id: alan.id, name: nil, kind: "h3")
      expect(heading).to_not be_valid
    end
    it "should set a kind on create if not passed passed" do
      heading = Heading.new(member_id: alan.id, name: 'Tester')
      expect(heading.kind).to eq nil
      heading.save
      expect(heading.kind).to eq "h1"
    end
  end
end
