class Diet < ActiveRecord::Base

  attr_accessible	:name
  
  has_many :restrictions
  has_many :people, :class_name => "Person", :through => :restrictions

  has_many :diet_listings
  has_many :listings, :through => :diet_listings 

end
