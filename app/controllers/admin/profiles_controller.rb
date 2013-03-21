class Admin::ProfilesController < ApplicationController

  layout "layouts/admin"
  before_filter :super_admin

  def index
    if params[:search].nil?
      @profiles = Person.all.paginate(:per_page => 15, :page => params[:page])
    else
      @profiles = Person.admin_search(params[:search]).paginate(:per_page => 15, :page => params[:page])
    end
  end

  def new
    @communities = Community.all
    @person = Person.new
    @path = admin_profiles_path
  end

  def create
    @communities = Community.all
    @person = Person.new(params[:person])
    @community = Community.where(:id => params[:community]).first
    @person.set_default_preferences
     respond_to do |format|
      if @person.save
        unless @community.nil?
          @community_membership = CommunityMembership.create!(:person_id => @person.id, :community_id => @community.id, :admin => false, :consent => @community.consent )
          Delayed::Job.enqueue(CommunityJoinedJob.new(@person.id, @community.id, request.host))
        end
        format.html { redirect_to(admin_profiles_path(:type => "profiles" ), :notice => 'New Person Added.') }
        format.xml  { render :xml => @person, :status => :created, :location => @person }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @person.errors, :status => :unprocessable_entity }
      end
    end
  end

  def edit
    @person = Person.find_by_id(params[:id])
    @path = admin_profile_path(:id => @person.id.to_s)
    unless @person.location
      @person.build_location(:address => @person.street_address,:type => 'person')
      @person.location.search_and_fill_latlng
    end
  end

  def update
    @person = Person.find_by_id(params[:id])

	  if params[:person] && params[:person][:location] && (params[:person][:location][:address].empty?) || (params[:person][:street_address].blank? || params[:person][:street_address].empty?)
      params[:person].delete("location")
      if @person.location
        @person.location.delete
      end
	  end

    respond_to do |format|
      if @person.update_attributes( params[:person] )
        format.html { redirect_to admin_profiles_path(:type => "profiles"), :notice => "User Information successfully updated" }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @profile.errors, status: :unprocessable_entity }
      end
    end
  end

  def show
    @profile = Person.find_by_id(params[:id])
  end

  def destroy
    @profile = Person.find_by_id(params[:id])
    @profile.destroy

    respond_to do |format|
      format.html { redirect_to admin_profiles_path(:type => "profiles"), :notice => "User successfully removed." }
      format.json { head :no_content }
    end
  end

end
