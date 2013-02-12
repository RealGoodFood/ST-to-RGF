class SwapItem < ActiveRecord::Base
  attr_accessible :offerer_id, :receiver_id, :offerer_listing_id, :receiver_listing_id, :acceptance, :community_id, :receiver_communication_mode
   
  validates_presence_of :offerer_id, :receiver_id, :offerer_listing_id, :receiver_listing_id

  belongs_to :person

  scope :not_replied, where("acceptance is null")

end
