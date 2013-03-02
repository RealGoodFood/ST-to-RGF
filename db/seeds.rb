# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ :name => 'Chicago' }, { :name => 'Copenhagen' }])
#   Mayor.create(:name => 'Daley', :city => cities.first)
#  listing_type = valid_st.keys[SecureRandom.random_number(valid_st.keys.length)]

# Person.all.each { |p| p.set_default_preferences }
# 
# user = Person.first
# for i in 1..500
#   listing_type = Listing::VALID_TYPES[SecureRandom.random_number(2)]
#   category = Listing::VALID_CATEGORIES[SecureRandom.random_number(4)]
#   valid_until = DateTime.now + 1.month
#   tag_list = [
#     "#{SecureRandom.random_number(33) + 1}tag",
#     "#{SecureRandom.random_number(33) + 1}longertag",
#     "#{SecureRandom.random_number(33) + 1}verylongtag"
#   ]
#   listing = user.create_listing(:listing_type => listing_type, :category => category, :valid_until => valid_until, :tag_list => tag_list, :description => "Test #{listing_type} #{category}")
#   
#   if(category.eql? "rideshare")
#     origin_lat = SecureRandom.random_number() * 0.15 + 60.15
#     origin_lng = SecureRandom.random_number() * 0.5 + 24.70
#     listing.build_origin_loc(:latitude => origin_lat, :longitude => origin_lng)
#     dest_lat = SecureRandom.random_number() * 0.15 + 60.15
#     dest_lng = SecureRandom.random_number() * 0.5 + 24.70
#     listing.build_destination_loc(:latitude => dest_lat, :longitude => dest_lng)
#     listing.origin = "Origin #{i}"
#     listing.destination = "Destination #{i}"
#   else
#     lat = SecureRandom.random_number() * 0.15 + 60.15
#     lng = SecureRandom.random_number() * 0.5 + 24.70
#     listing.build_location(:latitude => lat, :longitude => lng)
#     listing.title = "#{listing_type} - #{category} - test#{i}"
#   end
#   
#   if(Listing::VALID_SHARE_TYPES[listing_type][category])
#     share_type = Listing::VALID_SHARE_TYPES[listing_type][category][SecureRandom.random_number(Listing::VALID_SHARE_TYPES[listing_type][category].length)]
#     listing.share_types.build(:name => share_type)
#   end
#   listing.save
#   Community.find_by_domain("aalto").listings << listing
# end
  
  Community.create([{:id => 1, :name => "Ann Arbor", :domain => "annarbor", :consent => "SHARETRIBE1.0", :email_admins_about_new_members => false, :use_fb_like => false,
  :real_name_required => true, :feedback_to_admin => false, :automatic_newsletters => true, :join_with_invite_only => false,
  :use_captcha => false, :email_confirmation => true, :users_can_invite_new_users => false, :select_whether_name_is_shown_to_everybody => false,
  :private => false, :show_date_in_listings_list => false, :news_enabled => true, :all_users_can_add_news => true,
  :custom_frontpage_sidebar => false, :event_feed_enabled => true, :members_count => 1, :slogan => "Swap, Share",
  :description => "RealGoodFood is a place to swap recipes.", :category => "town", :polls_enabled => false, :plan => "premium"},
  {:id => 2, :name => "Durham city", :domain => "durham", :consent => "SHARETRIBE1.0", :email_admins_about_new_members => false, :use_fb_like => false,
  :real_name_required => true, :feedback_to_admin => false, :automatic_newsletters => true, :join_with_invite_only => false,
  :use_captcha => false, :email_confirmation => true, :users_can_invite_new_users => false, :select_whether_name_is_shown_to_everybody => false,
  :private => false, :show_date_in_listings_list => false, :news_enabled => true, :all_users_can_add_news => true,
  :custom_frontpage_sidebar => false, :event_feed_enabled => true, :members_count => 1, :slogan => "Swap, Share",
  :description => "RealGoodFood is a place to swap recipes.", :category => "town", :polls_enabled => false, :plan => "premium"}])
  
  
  Person.create!(:locale => "en", :active_days_count => 0, :test_group_number => 1,
  :active => true, :show_real_name_to_other_users => true, :given_name => "Devin", :family_name => "Mcintire", :username => "devin",
  :email => "chaitanya.saraf@gmail.com", :password => "chaitanya", :password_confirmation => "chaitanya",
  :confirmed_at => "2012-11-13 05:46:17", :confirmation_sent_at => "2012-11-13 05:45:48", :hobby_status => "Existing")
  
  
  Location.create([{:id => 1, :latitude => "42.2804", :longitude => "-83.744", :address => "Ann Arbor, MI 48104, USA",
  :google_address => "199 S Division St, Ann Arbor, MI 48104, USA", :location_type => "community", :community_id => 1,
  :city => "Ann Arbor"},
  {:id => 2, :latitude => "35.9981", :longitude => "-78.892", :address => "Durham, NC 27701, USA",
  :google_address => "Durham, NC 27701, USA", :location_type => "community", :community_id => 2,
  :city => "Durham"}])
  
  
  
  
  
  
