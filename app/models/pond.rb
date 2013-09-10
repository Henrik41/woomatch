class Pond < ActiveRecord::Base
  attr_accessible :address, :address_country, :address_latitude, :address_locality, :address_longitude
end
