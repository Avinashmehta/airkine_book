class Passenger < ActiveRecord::Base
	validates :pass_name, presence: true

end
