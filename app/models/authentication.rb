class Authentication < ActiveRecord::Base

  belongs_to :person
  attr_accessible :community_id, :user_id, :provider, :uid
  validates_presence_of :user_id, :uid, :provider
  validates_uniqueness_of :uid, :scope => :provider

  def self.from_omniauth(auth)
    where(auth.slice("provider", "uid")).first || create_from_omniauth(auth)
  end

  def self.create_from_omniauth(auth)
    user = User.where(:email => auth["info"]["email"])
    unless user.nil?
      create! do |authentication|
        authentication.provider = auth["provider"]
        authentication.uid = auth["uid"]
        authentication.user_id = user.id
      end
    end
  end

end
