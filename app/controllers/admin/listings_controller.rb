class Admin::ListingsController < ApplicationController

  layout "layouts/admin"
  before_filter :super_admin

  def index
    if params[:search].nil?
      @listings = Listing.all.paginate(:per_page => 10, :page => params[:page])
    else
      @listings = Listing.admin_search(params[:search]).paginate(:per_page => 10, :page => params[:page])
    end
  end

  def edit
    @listing = Listing.find_by_id(params[:id])
    @path = admin_listing_path(:id => @listing.id.to_s)
    if !@listing.origin_loc
	    @listing.build_origin_loc(:location_type => "origin_loc")
	  end
    1.times { @listing.listing_images.build } if @listing.listing_images.empty?
  end

  def update
    @listing = Listing.find_by_id(params[:id])
    if (params[:listing][:origin] && (params[:listing][:origin_loc_attributes][:address].empty? || params[:listing][:origin].blank?))
      params[:listing].delete("origin_loc_attributes")
      if @listing.origin_loc
        @listing.origin_loc.delete
      end
    end
    if @listing.update_fields(params[:listing])
      @listing.location.update_attributes(params[:location]) if @listing.location
      flash[:notice] = "#{@listing.listing_type}_updated_successfully"
      #Delayed::Job.enqueue(ListingUpdatedJob.new(@listing.id, request.host))
      redirect_to admin_listings_path(:type => "listings")
    else
      render :action => :edit
    end    
  end

  def show
    @listing = Listing.find_by_id(params[:id])
    @comments = Comment.where(:listing_id => @listing.id)

  end

  def destroy
    @listing = Listing.find_by_id(params[:id])
    @listing.update_attributes(:open => false )

    respond_to do |format|
      format.html { redirect_to admin_listings_path(:type => "listings"), :notice => "Listing successfully closed." }
      format.json { head :no_content }
    end
  end


end
