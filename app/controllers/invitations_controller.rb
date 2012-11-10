class InvitationsController < ApplicationController
  
  skip_filter :dashboard_only
  
  before_filter :only => :create do |controller|
    controller.ensure_logged_in "you_must_log_in_to_invite_new_user"
  end
  
  before_filter :users_can_invite_new_users, :only => :create

  def new
    @invitation = Invitation.new(params[:invitation])
  end
  
  def create
    @invitation = Invitation.new(params[:invitation])
    if @invitation.save
      notice = [:notice, "invitation_sent"]
      Delayed::Job.enqueue(InvitationCreatedJob.new(@invitation.id, request.host))
    else
      notice = [:error, "invitation_could_not_be_sent"]
    end
    respond_to do |format|
      format.html { 
        flash[notice[0]] = notice[1]
        redirect_to root 
      }
      format.js {
        flash.now[notice[0]] = notice[1]
        render :layout => false 
      }
    end
  end
  
  private
  
  def users_can_invite_new_users
    unless @current_community.users_can_invite_new_users || @current_user.has_admin_rights_in?(@current_community)
      flash[:error] = "inviting_new_users_is_not_allowed_in_this_community"
      redirect_to root and return
    end
  end
  
end
