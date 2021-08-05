class User < ApplicationRecord
    enum user_type: %i[patient admin]

    validates :phone_number, :presence => true, :numericality => true, :length => { :minimum => 10, :maximum => 10 }
    validates :pincode, :presence => true, :numericality => true
end
