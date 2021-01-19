class Friendship < ApplicationRecord
    belongs_to :friend_a, class_name: :Member
    belongs_to :friend_b, class_name: :Member
end
