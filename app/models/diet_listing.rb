class DietListing < ActiveRecord::Base
  attr_accessible	:listing_id, :diet_id

  belongs_to :listing
  belongs_to :diet

end
