class Heading < ApplicationRecord
    belongs_to :member

    validates_presence_of :name

    # if the heading kind is not provided, set it to h1
    before_validation(on: :create) do
        unless attribute_present?("kind")
            self.kind = "h1"
        end
    end
end
