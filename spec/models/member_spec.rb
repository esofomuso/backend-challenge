require 'rails_helper'

RSpec.describe Member, type: :model do
  let (:alan) { Member.create(name: 'Alan', url: 'http://www.alanswebsite.com') }
  let (:bart) { Member.create(name: 'Bart', url: 'http://www.bartswebsite.com') }
  let (:claudia) { Member.create(name: 'Claudia', url: 'http://www.claudiaswebsite.com') }
  let (:doug) { Member.create(name: 'Doug', url: 'http://www.dougswebsite.com') }
  let (:ed) { Member.create(name: 'Ed', url: 'http://www.edswebsite.com') }
  let (:finn) { Member.create(name: 'Finn', url: 'http://www.finnswebsite.com') }
  let (:george) { Member.create(name: 'George', url: 'http://www.georgeswebsite.com') }
  let (:alan_headings) { alan.headings.create([{name: 'Dog breeds'}, {name:'Cat breeds'}]) }
  let (:bart_headings) { bart.heading.create([{name: 'Fresh produce'}, {name: 'Seasonal specials'}]) }
  let (:claudia_headings) { claudia.heading.create([{name:'Dog breeding in Ukraine'}, {name: 'Dog Sitting'}, {name:'Cat breeding'}]) }
  let (:doug_headings) { doug.heading.create( [{name:'Fast foods'}, {name:'Delivery'}, {name:'Catering'}]) }
  let (:ed_headings) { ed.heading.create( [{name:'Dog breeding by Ed'}, {name:'Cat Sitting'}, {name:'Cat breeding by experts'}])}
  let (:finn_headings) { finn.headings.create( [{name:'Dog Breeding'}, {name:'fishing'}]) }
  let (:george_headings) { george.headings.create( [{name:'Hosting'}, {name:'Delivery'}, {name:'Catering'}]) }
  
  # 'Alan': ['Bart', 'Hans', 'Doug'],
  #   'Bart': ['Alan', 'Claudia', 'Doug'],
  #   'Claudia': ['Bart', 'Doug', 'Finn'],
  #   'Doug': ['Alan', 'Bart', 'Claudia'],
  #   'Ed': ['Brian'],
  #   'Finn': ['Claudia', 'George', 'Ian'],
  #   'George': ['Finn', 'Ian'],
  context "Validation" do
    it "is valid with valid attributes" do
      member = Member.new(name: 'Tester', url: 'www.test.com')
      expect(member).to be_valid
    end
    it "is not valid without a name" do
      member = Member.new(name: nil, url: 'www.testing.com')
      expect(member).to_not be_valid
    end
    it "is not valid without a height" do
      member = Member.new(name: 'Tester1', url: nil)
      expect(member).to_not be_valid
    end
    it "should generate short_url on create using string passed" do
      member = Member.new(name: 'Tester', url: 'www.test.com', short_url: 'X123YfT')
      member.save
      expect(member.short_url).to eq "https://bit.ly/X123YfT"
    end
    it "should generate short_url on create when string is not passed" do
      member = Member.new(name: 'Tester', url: 'www.test.com')
      expect(member.short_url).to eq nil
      member.save
      expect(member.short_url).to_not eq nil
    end

  end

  context "Headings" do
    
  end

  context "Friends" do
    let (:friendship1) { alan.friend_bs = [bart, george, doug]}
    let (:friendship2) { claudia.friend_bs = [bart, doug, finn]}
    it "should return friends through friend_b relationships" do
      friendship1
      friendship2
      expect(alan.friends.map(&:id).sort).to eq [bart, george, doug].map(&:id).sort
      expect(doug.friends.map(&:id).sort).to eq [alan, claudia].map(&:id).sort 
    end
    it "should return friends through friend_a and friend_b relationships" do
      friendship1
      friendship2
      doug.friend_bs << bart
      expect(doug.friends.map(&:id).sort).to eq [alan, claudia, bart].map(&:id).sort
    end
  end
  
end
