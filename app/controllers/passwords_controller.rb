class PasswordsController < Devise::PasswordsController
  skip_filter :dashboard_only, :single_community_only, :not_public_in_private_community

  layout :choose_layout
  
  private
  
  def choose_layout
    on_dashboard? ? "dashboard" : "application"
  end

end