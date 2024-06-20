class Gemstone < ApplicationRecord
    has_many :games

    validates :name, 
    presence: { message: "Gemstones must have a name"}, 
    uniqueness: { message: "This gemstone already exists"}, 
    length: { in: 2..100, message: "Name length must be between 2 and 100 characters"}

    validates :image_url, 
    presence: { message: "Image URL can't be empty"},
    uniqueness: { message: "Image URL already exists"},
    :url => true

    validates :can_be_found_in, 
    presence: { message: "There must be at least one country where the gemstone can be found"}

end
