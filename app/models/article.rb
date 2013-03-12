class Article < ActiveRecord::Base

  belongs_to :person
  has_many :article_comments
  attr_accessible :title, :description, :story, :image_file_name, :image_content_type, :image_file_size, :author_id

  validates_presence_of :title, :description, :author_id

  paperclip_options = {
        :styles => { :medium => "200x350>", :thumb => "50x50#", :original => "600x800>" },
        :storage => :cloud_files,
        :cloudfiles_credentials =>  "#{RAILS_ROOT}/config/rackspace.yml"
        }

  has_attached_file :image, paperclip_options
        
  #validates_attachment_presence :image
  validates_attachment_size :image, :less_than => 5.megabytes
  validates_attachment_content_type :image,
                                    :content_type => ["image/jpeg", "image/png", "image/gif", 
                                      "image/pjpeg", "image/x-png"] #the two last types are sent by IE. 

end
