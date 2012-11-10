class SwapItem < ActiveRecord::Base
  attr_accessible :offerer_id, :receiver_id, :offerer_listing_id, :receiver_listing_id, :acceptance
   
  validates_presence_of :offerer_id, :receiver_id, :offerer_listing_id, :receiver_listing_id



end
