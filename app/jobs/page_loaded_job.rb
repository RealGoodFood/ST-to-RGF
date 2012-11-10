class PageLoadedJob < Struct.new(:community_membership_id, :host) 
  
  # This before hook should be included in all Jobs to make sure that the service_name is 
  # correct as it's stored in the thread and the same thread handles many different communities
  # if the job doesn't have host parameter, should call the method with nil, to set the default service_name
  def before(job)
    # Set the correct service name to thread for I18n to pick it
    ApplicationHelper.store_community_service_name_to_thread_from_host(host)
  end
  
  def perform
    membership = CommunityMembership.find(community_membership_id)
    unless membership.last_page_load_date && membership.last_page_load_date.to_date.eql?(Date.today)
      membership.update_attribute(:last_page_load_date, DateTime.now)
      # FIXME: Day counting and badge check disabled as it produced too big numbers for unknown reason
      #current_user.active_days_count += 1
      #Badge.assign_with_levels("enthusiast", current_user.active_days_count, current_user, [5, 30, 100], host)
    end
  end
  
end