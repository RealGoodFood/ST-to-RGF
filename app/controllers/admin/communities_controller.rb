class Admin::CommunitiesController < ApplicationController

  layout "layouts/admin"
  before_filter :super_admin

  def index
    if params[:search].nil?
      @communities = Community.all.paginate(:per_page => 15, :page => params[:page])
    else
      @communities = Community.search(params[:search]).paginate(:per_page => 15, :page => params[:page])
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
