class Article < ActiveRecord::Base

  belongs_to :author, :class_name => "Person"
  has_many :article_comments

   has_attached_file :image, :styles => { :medium => "200x350>", :thumb => "50x50#" },
                     :storage => :cloud_files,
                     :cloudfiles_credentials =>  "#{RAILS_ROOT}/config/rackspace.yml"

#  attr_accessible :title, :description, :story, :author_id, :image,
#                  :image_file_name, :image_content_type, :image_file_size

  validates_attachment_presence :image
  validates_attachment_size :image, :less_than => 5.megabytes
  validates_attachment_content_type :image,
                                    :content_type => ["image/jpeg", "image/png", "image/gif", 
                                      "image/pjpeg", "image/x-png"] #the two last types are sent by IE. 

  validates_presence_of :title, :description, :author_id
end
