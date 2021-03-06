class User < ApplicationRecord
    default_scope -> { order(created_at: :desc) }
    
    # Validations
    validates_presence_of :name, :status, :phone
    validates :email, presence: true, length: { maximum: 50, minimum: 5 },
                        uniqueness: { case_sensitive: false },
                        format: { with: /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\z/i, message: 'Email invalid' }


    def self.search(search)
        if search
            @parameter = search.downcase
            where('name LIKE ?', "%#{@parameter}%")
        else
            all 
        end
    end
end
