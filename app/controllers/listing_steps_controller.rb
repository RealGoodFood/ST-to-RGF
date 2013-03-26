class ListingStepsController < ApplicationController
#  include Wicked::Wizard
#  steps :information, :date_and_location, :additional_details

  def title
    @listing = Listing.find_by_id(params[:id])
  end

  def information
    @listing = Listing.find_by_id(params[:id])
    1.times { @listing.listing_images.build } if @listing.listing_images.empty?
  end

  def date_and_location
    @listing = Listing.find_by_id(params[:id])
    if (@current_user.location != nil)
     temp = @current_user.location
     temp.location_type = "origin_loc"
     @listing.build_origin_loc(temp.attributes)
    else
      @listing.build_origin_loc(:location_type => "origin_loc") if !@listing.origin_loc
    end
  end

  def additional_details
    @listing = Listing.find_by_id(params[:id])
  end

  def update
    if (params[:listing][:origin] && params[:listing][:origin_loc_attributes] && (params[:listing][:origin_loc_attributes][:address].empty? || params[:listing][:origin].blank?))
      params[:listing].delete("origin_loc_attributes")
      if @listing.origin_loc
        @listing.origin_loc.delete
      end
    end
    @listing = Listing.find_by_id(params[:id])
    if @listing.update_attributes(params[:listing])
      if params[:back_button].nil?
        if params[:listing][:current_step] == "title"
          redirect_to  information_listing_step_path(@listing.id)
        elsif params[:listing][:current_step] == "information"
          redirect_to  date_and_location_listing_step_path(@listing.id)
        elsif params[:listing][:current_step] == "date_and_location"
          redirect_to  additional_details_listing_step_path(@listing.id)
        else
          flash[:notice] = "Recipe Saved"
          redirect_to listing_path(@listing)
        end 
      else
        if params[:listing][:current_step] == "information"
          redirect_to  title_listing_step_path(@listing.id)
        elsif params[:listing][:current_step] == "date_and_location"
          redirect_to  information_listing_step_path(@listing.id)
        elsif params[:listing][:current_step] == "additional_details"
          redirect_to  date_and_location_listing_step_path(@listing.id)
        end 
      end            
    else
      render :action => params[:listing][:current_step]
    end   
  end

end
