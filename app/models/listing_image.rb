class ListingImage < ActiveRecord::Base

  belongs_to :listing
  
  paperclip_options = {
      :styles => { :medium => "300x640>", :thumb => "85x85#", :original => "300x640>" }
#      :storage => :cloud_files,
#      :cloudfiles_credentials =>  "#{RAILS_ROOT}/config/rackspace.yml"
#        :path => ":rails_root/public/system/:attachment/:id/:style/:filename",
#        :url => "/system/:attachment/:id/:style/:filename"
        }

  if APP_CONFIG.s3_bucket_name && APP_CONFIG.aws_access_key_id && APP_CONFIG.aws_secret_access_key
    paperclip_options.merge!({
      :path => "images/:class/:attachment/:id/:style/:filename",
      :url => "/system/:class/:attachment/:id/:style/:filename",
      :storage => :s3,
      :s3_protocol => 'https',
      :s3_credentials => {
            :bucket            => APP_CONFIG.s3_bucket_name, 
            :access_key_id     => APP_CONFIG.aws_access_key_id, 
            :secret_access_key => APP_CONFIG.aws_secret_access_key 
      }
    })
  end
  
  has_attached_file :image, paperclip_options
  validates_attachment_presence :image
  validates_attachment_size :image, :less_than => 3.megabytes, :unless => "image_file_name.blank?"
  validates_attachment_content_type :image,
                                    :content_type => ["image/jpeg", "image/png", "image/gif", "image/pjpeg", "image/x-png"]
                                    #the two last types are sent by IE. 


end
