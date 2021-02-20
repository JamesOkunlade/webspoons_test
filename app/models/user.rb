class User < ApplicationRecord
    # Validations
    validates_presence_of :name, :email, :status, :phone
end
