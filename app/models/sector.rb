class Sector < ActiveRecord::Base
validates :airline_no, presence: true
validates :base_fare, presence: true
end
