class Post < ApplicationRecord
    validates :item_name , {presence: true}
    validates :user_id , {presence: true}
    validates :image_name , {presence: true}
    
    has_one_attached :image

    def user
        return User.find_by(id: self.user_id)
    end

end
