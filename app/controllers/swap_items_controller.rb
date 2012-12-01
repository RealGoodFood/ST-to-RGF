class SwapItemsController < ApplicationController


  layout :choose_layout

  skip_filter :dashboard_only
  skip_filter :not_public_in_private_community, :only => :sign_in

  before_filter :only => [ :show, :edit, :update, :new, :create, :index, :inbox, :outbox ] do |controller|
    controller.ensure_logged_in "you_must_log_in_to_view_this_content"
  end

  # GET /swap_items
  # GET /swap_items.xml

  def index
    @received_swap_offers = SwapItem.where(:receiver_id => @current_user.id ).order('id Desc')
    @sent_swap_offers = SwapItem.where(:offerer_id => @current_user.id ).order('id Desc')

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @swap_items }
    end
  end

  # GET /swap_items/1
  # GET /swap_items/1.xml
  def show
    @swap_item = SwapItem.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @swap_item }
    end
  end

  # GET /swap_items/new
  # GET /swap_items/new.xml
  def new
    @receiver = Person.find_by_id(params[:recd]) 
    @receiver_listing = Listing.find_by_id(params[:id]) 
    @swap_item = SwapItem.new
  
    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @swap_item }
    end
  end

  # GET /swap_items/1/edit
  def edit
    @swap_item = SwapItem.find(params[:id])
  end

  # POST /swap_items
  # POST /swap_items.xml
  def create
    @swap_item = SwapItem.new(params[:swap_item])

    respond_to do |format|
      if @swap_item.save
        format.html { redirect_to(community_home_path, :notice => 'Swap offer has been sent.') }
        format.xml  { render :xml => @swap_item, :status => :created, :location => @swap_item }
#        PersonMailer.swap_offer(@swap_item, request.host).deliver
        Delayed::Job.enqueue(SwapOfferJob.new(@swap_item.id, request.host, @current_community.id))
      else
        format.html { redirect_to(community_home_path, :notice => 'Swap offer has been not sent, Please try again') }
        format.xml  { render :xml => @swap_item.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /swap_items/1
  # PUT /swap_items/1.xml
  def update
    @swap_item = SwapItem.find(params[:id])

    respond_to do |format|
      if @swap_item.update_attributes(params[:swap_item])
        format.html { redirect_to(@swap_item, :notice => 'Swap item was successfully updated.') }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @swap_item.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /swap_items/1
  # DELETE /swap_items/1.xml
  def destroy
    @swap_item = SwapItem.find(params[:id])
    @swap_item.destroy

    respond_to do |format|
      format.html { redirect_to(swap_items_url) }
      format.xml  { head :ok }
    end
  end

  def direct_update
    @swap_item = SwapItem.find(params[:id])
    @swap_item.update_attribute(:acceptance,  params[:accept])
    Delayed::Job.enqueue(SwapOfferAcceptanceJob.new(@swap_item.id, request.host, @current_community.id))
    redirect_to :back
  end
  
#  def inbox
#    @received_swap_offers = SwapItem.where(:receiver_id => @current_user.id ).order('id Desc')
#  end

#  def outbox
#    @sent_swap_offers = SwapItem.where(:offerer_id => @current_user.id ).order('id Desc')
#  end

  private
  
  def choose_layout
    if @current_community && @current_community.private && action_name.eql?("new")
      'private'
    else
      'application'
    end
  end


end
