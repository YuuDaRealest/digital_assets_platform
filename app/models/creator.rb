class Creator < ApplicationRecord
    has_many :digital_assets, dependent: :destroy
end
