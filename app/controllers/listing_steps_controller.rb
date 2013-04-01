class ListingStepsController < ApplicationController

   before_filter :only => [ :title, :information, :date_and_location, :additional_details, :update ] do |controller|
    controller.ensure_logged_in "you_must_log_in_to_view_this_content"
  end

  before_filter :only => [ :title, :information, :date_and_location, :additional_details, :update ] do |controller|
    controller.ensure_current_user_is_listing_author "only_listing_author_can_edit_a_listing"
  end
  
  skip_filter :dashboard_only

  def title
    @listing = Listing.find_by_id(params[:id])
  end

  def information
    @listing = Listing.find_by_id(params[:id])
    1.times { @listing.listing_images.build } if @listing.listing_images.empty?
  end

  def date_and_location
    @listing = Listing.find_by_id(params[:id])
    if !@listing.origin_loc
	      @listing.build_origin_loc(:location_type => "origin_loc")
	  end
  end

  def additional_details
    @listing = Listing.find_by_id(params[:id])
  end

  def update
    @listing = Listing.find_by_id(params[:id])

    if (params[:listing][:origin] && params[:listing][:origin_loc_attributes] && (params[:listing][:origin_loc_attributes][:address].empty? || params[:listing][:origin].blank?))
      params[:listing].delete("origin_loc_attributes")
      if @listing.origin_loc
        @listing.origin_loc.delete
      end
    end

    if @listing.update_attributes(params[:listing])
      if params[:back_button].nil?
        if params[:listing][:current_step] == "title"
          redirect_to  information_listing_step_path(@listing.id)
        elsif params[:listing][:current_step] == "information"
          redirect_to  date_and_location_listing_step_path(@listing.id)
        elsif params[:listing][:current_step] == "date_and_location"
          redirect_to  additional_details_listing_step_path(@listing.id)
        else
          flash[:notice] = "Food Saved"
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

  def ensure_current_user_is_listing_author(error_message)
    @listing = Listing.find(params[:id])
    return if current_user?(@listing.author) || @current_user.has_admin_rights_in?(@current_community)
    flash[:error] = error_message
    redirect_to @listing and return
  end

end
