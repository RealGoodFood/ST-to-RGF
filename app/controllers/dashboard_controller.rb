class DashboardController < ApplicationController
  
  include CommunitiesHelper
  
  skip_filter :single_community_only
  skip_filter :dashboard_only, :only => :api
  skip_filter :fetch_community, :only => [:api, :index ]
  
  def index
    logger.info "~~~~~~~~~~~~~~~dashboard#index~~~~~~~~~#{session[:selected_community]}"
    I18n.locale = "es" if request.domain =~ /\.cl$/ && params[:locale].blank?
    session[:selected_community] = nil
    clear_session_variables
    @communities = Community.order("name asc")
    @community = Community.where(:name => "Ann Arbor" ).first
  end
  
  # A custom action for World Design Capital 
  # Helsinki 2012 special page
  def wdc
    I18n.locale = "fi"
    @communities = Community.where(:label => "wdc").order("name")
  end
  
  # A custom action for World Design Capital 
  # Helsinki 2012 special page
  def okl
    I18n.locale = "fi"
    @communities = Community.where(:label => "okl").order("name")
  end
  
  def faq
    
  end
  
  def api
    
  end
  
  def pricing
    
  end
  
  # This is for all the custom "campaign" sites
  def campaign
    case params[:page_type]
    when "wdc"
      @communities = Community.where(:label => "wdc").order("name")
      render :wdc
    when *["okl","omakotiliitto"]
      @communities = Community.where(:label => "okl").order("name")
      render :okl
    else
      @contact_request = ContactRequest.new
      render :index
    end
  end
  
end
