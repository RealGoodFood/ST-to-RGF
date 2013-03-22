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
    unless @community.location
      if (@current_community.location != nil)
        temp = @current_community.location
        temp.location_type = "community"
        @community.build_location(temp.attributes)
      logger.info ">>>>>#{temp.attributes}>>>>>>>>>>>>>Community Location>>>>>>>>>>>>>>>>>>>>>>>>>>#{@community.location}"
      end
    end
    @path = admin_communities_path
  end

  def create
    @path = admin_communities_path
    params[:community][:location][:address] = params[:community][:address] if params[:community][:address]
    logger.info ">>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>#{params[:community]}"
    location = Location.new(params[:community][:location])
    params[:community].delete(:location)
    params[:community].delete(:address)
    @community = Community.new(params[:community])
    en = "en"
    ary = Array(en);
    @community.settings = {"locales"=> ary } #["#{params[:community_locale]}"]
    @community.email_confirmation = true
    @community.plan = "free"#session[:pricing_plan]
    @community.users_can_invite_new_users = true
    @community.use_captcha = false
     respond_to do |format|
      if @community.save
        location.community = @community
        location.save
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
