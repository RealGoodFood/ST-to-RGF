# Invitation stores the invitation (and codes) that people need to join certain communities

class Invitation < ActiveRecord::Base
  
  #include ApplicationHelper
  
  has_many :community_memberships #One invitation can result many users joining.
  belongs_to :community
  belongs_to :inviter, :class_name => "Person", :foreign_key => "inviter_id"
  
  validates_presence_of :community_id # The invitation must relate to one community
  
  validates_presence_of :code #generated automatically
  validates_uniqueness_of :code
  
  validates_length_of :message, :maximum => 5000, :allow_nil => true
  
  before_validation(:on => :create) do
    self.code ||= ApplicationHelper.random_sting.upcase
    self.usages_left ||= 1
  end
    
  def usable?
    return usages_left > 0 && (valid_until.nil? || valid_until > DateTime.now)
  end
  
  def use_once!
    raise "Invitation is not usable" if not usable?
    update_attribute(:usages_left, self.usages_left - 1)
  end
  
  def self.code_usable?(code, community=nil)
    invitation = Invitation.find_by_code(code.upcase) if code.present?
    if invitation.present?
      return false if community.present? && invitation.community_id != community.id
      return invitation.usable?    
    else
      return false
    end
  end
  
  def self.use_code_once(code)
    invitation = Invitation.find_by_code(code.upcase) if code.present?
    return false if invitation.blank?
    invitation.use_once!
    return true
  end
  
  # Can be used to invite many users with a list of emails
  # The invitation language is the language of the inviter user
  def self.invite_many_users(email_array, community_host, community_id, inviter_id, message=nil, information=nil)
    email_array.each do |email|
      inv = Invitation.new(:email => email, :community_id => community_id, :inviter_id => inviter_id, :message => message, :information => information)
      inv.save
      Delayed::Job.enqueue(InvitationCreatedJob.new(inv.id, community_host))
    end
    
  end

end
