class Admin::CommunitiesController < ApplicationController
  include CommunitiesHelper
  layout "layouts/admin"
  before_filter :super_admin

  def index
    if params[:search].nil?
      @communities = Community.all.paginate(:per_page => 15, :page => params[:page])
    else
      @communities = Community.search(params[:search]).paginate(:per_page => 15, :page => params[:page])
    end
  end

  def new
    @community = Community.new
    @community.community_memberships.build
    unless @community.location
      @community.build_location(:address => @community.address, :location_type => 'community')
      @community.location.search_and_fill_latlng
    end
    @path = admin_communities_path
  end

  def create
    @community = Community.new(params[:community])
     respond_to do |format|
      if @community.save
        unless @community.location
          @community.build_location(:address => @community.address, :location_type => 'community')
          @community.location.search_and_fill_latlng
        end
        format.html { redirect_to(admin_communities_path, :notice => 'New Community Added.') }
        format.xml  { render :xml => @community, :status => :created, :location => @community }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @community.errors, :status => :unprocessable_entity }
      end
    end
  end

  def edit
    @community = Community.find_by_id(params[:id])
    @path = admin_community_path(:id => @community.id.to_s)
  end

  def update
    @community = Community.find_by_id(params[:id])

    respond_to do |format|
      if @community.update_attributes(params[:community])
        format.html { redirect_to admin_communities_path(:type => "communities"), :notice => "Community successfully updated" }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @community.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @community = Community.find_by_id(params[:id])
    @community.destroy

    respond_to do |format|
      format.html { redirect_to admin_communities_path(:type => "communities"), :notice => "Community successfully removed." }
      format.json { head :no_content }
    end
  end

end
