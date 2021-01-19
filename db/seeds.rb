# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
# google: https://bit.ly/3nUxTkE
def add_member(k,v)
    m = Member.find_by_name(k) || Member.create(name: v[:name], url: v[:url], short_url: v[:short_url])
    v[:headings].each do |h|
        m.headings.create(kind: 'h1', name: h)
    end
    m
end

test_member_data = {
    'Alan' => {
        name: 'Alan',
        url: 'http://www.google.com',
        short_url: '3nUxTkE',
        headings: ['Dog breeds', 'Cat breeds', 'Fish types']
    },
    'Bart' => {
        name: 'Bart',
        url: 'http://www.bartsgardens.com',
        short_url: nil,
        headings: ['Fresh produce', 'Seasonal specials']
    },
    'Brian' => {
        name: 'Brian',
        url: 'http://www.lunchcooking.com',
        short_url: nil,
        headings: ['Fast foods', 'Delivery', 'Farm to table']
    },
    'Claudia' => {
        name: 'Claudia',
        url: 'http://www.breedlikeclaudia.com',
        short_url: nil,
        headings: ['Dog breeding in Ukraine', 'Dog Sitting', 'Cat breeding']
    },
    'Doug' => {
        name: 'Doug',
        url: 'http://www.dougscusine.com',
        short_url: nil,
        headings: ['Fast foods', 'Delivery', 'Catering']
    },
    'Ed' => {
        name: 'Ed',
        url: 'http://www.edthebreeder.com',
        short_url: nil,
        headings: ['Dog breeding by Ed', 'Cat Sitting', 'Cat breeding by experts']
    },
    'Finn' => {
        name: 'Finn',
        url: 'http://www.naturaldogfeed.com',
        short_url: nil,
        headings: ['Dog Breeding', 'fishing']
    },
    'George' => {
        name: 'George',
        url: 'http://www.cooklikegeorge.com',
        short_url: nil,
        headings: ['Hosting', 'Delivery', 'Catering']
    },
    'Hans' => {
        name: 'Hans',
        url: 'http://www.breedinghaven.com',
        short_url: nil,
        headings: ['Dog breeding', 'Delivery', 'Fishing breeding']
    },
    'Ian' => {
        name: 'Ian',
        url: 'http://www.iansdelicacies.com',
        short_url: nil,
        headings: ['Delicacies by location', 'Delivery', 'Catering']
    },
    'Jake' => {
        name: 'Jake',
        url: 'http://www.jakesdelicacies.com',
        short_url: nil,
        headings: ['Delicacies by location', 'Delivery', 'Catering']
    },
    'Max' => {
        name: 'Max',
        url: 'http://www.maxdogbreeding.com',
        short_url: nil,
        headings: ['Dog breeding']
    },
    'Nate' => {
        name: 'Nate',
        url: 'http://www.natecatbreeding.com',
        short_url: nil,
        headings: ['Cat breeding']
    }
}

friendships = {
    'Alan' => ['Bart', 'Hans', 'Doug'],
    'Bart' => ['Alan', 'Brian', 'Claudia', 'Doug'],
    'Brian' => ['Bart', 'Claudia', 'Ed'],
    'Claudia' => ['Bart', 'Brian', 'Doug', 'Finn'],
    'Doug' => ['Alan', 'Bart', 'Claudia'],
    'Ed' => ['Brian'],
    'Finn' => ['Claudia', 'George', 'Ian'],
    'George' => ['Finn', 'Ian'],
    'Hans' => ['Nate'],
    'Ian' => ['Finn', 'George'],
    'Max' => [],
    'Nate' => ['Hans']
}

test_member_data.each do |k,v|
    m = add_member(k,v)
    friendships[k].each do |f|
        m1 = Member.find_by_name(f) || add_member(f,test_member_data[f])
        Friendship.create(friend_a_id: m.id, friend_b_id: m1.id) unless m1.friends.include? m
    end   
end
