class Member < ApplicationRecord
    has_many :friendships, ->(member) { where("friend_a_id = ? OR friend_b_id = ?", member.id, member.id) }   
    has_many :friends, through: :friendships # , source: Member
    has_many :headings, dependent: :destroy

    has_many :friendships_as_friend_a, foreign_key: :friend_a_id, class_name: :Friendship, dependent: :destroy
    has_many :friendships_as_friend_b, foreign_key: :friend_b_id, class_name: :Friendship, dependent: :destroy
    has_many :friend_as, through: :friendships_as_friend_b
    has_many :friend_bs, through: :friendships_as_friend_a

    validates_presence_of :name, :url

    # Generate short url on create
    # This is a placeholder until I find a good gem to handle this
    # In the meantime, if a string is passed use it as the short_url
    # Else generate a random string to add to the domain to fake the short_url
    # TODO find a Gem that shortens urls
    before_validation(on: :create) do
        if attribute_present?("short_url")
            self.short_url = "https://bit.ly/" + short_url
        else
            self.short_url = "https://bit.ly/" + SecureRandom.uuid[0..6]
        end
    end

    def friendships
        self.friendships_as_friend_a + self.friendships_as_friend_b
    end

    # To ensure two-way friendship
    def friends
        self.friend_as + self.friend_bs
    end
end
