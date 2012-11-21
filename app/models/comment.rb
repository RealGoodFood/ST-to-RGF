class Comment < ActiveRecord::Base
  
  belongs_to :author, :class_name => "Person"
  belongs_to :listing
  has_many :notifications, :as => :notifiable, :dependent => :destroy
  
  attr_accessor :author_follow_status
  
  validates_length_of :content, :minimum => 1, :maximum => 5000, :allow_nil => false
  
  after_create :update_follow_status

  # Creates notifications related to this comment and sends notification emails
  def send_notifications(host)
    if !listing.author.id.eql?(author.id)
      Notification.create(:notifiable_id => id, :notifiable_type => "Comment", :receiver_id => listing.author.id, :description => "to_own_listing")
      if listing.author.should_receive?("email_about_new_comments_to_own_listing")
        PersonMailer.new_comment_to_own_listing_notification(self, host).deliver
      end
    end
    listing.notify_followers(host, author, false)
  end
  
  def update_follow_status
    if listing
      author.update_follow_status(listing, author_follow_status)
    end
  end
  
end
