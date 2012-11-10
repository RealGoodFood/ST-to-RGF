Given /^there is (item|favor|housing) (offer|request) with title "([^"]*)"(?: from "([^"]*)")?(?: and with share type "([^"]*)")?(?: and with tags "([^"]*)")?$/ do |category, type, title, author, share_type, tags|
  @listing = Factory(:listing, :listing_type => type, 
                               :category => category,
                               :title => title,
                               :share_type => share_type,
                               :author => (@people && @people[author] ? @people[author] : Person.first),
                               :communities => [Community.find_by_domain("test")]
                               )
  @listing.update_attribute(:tag_list, tags.split(", ")) if tags
end

# Given /^there is (item|favor|housing) (offer|request) with title "([^"]*)"(?: from "([^"]*)")?(?: and with share type "([^"]*)")?(?: and with tags "([^"]*)")?$/ do |category, type, title, author, share_type, tags|
#   @listing = Listing.create!(:listing_type => type, 
#                              :category => category, 
#                              :title => title,
#                              :description => "test",
#                              :tag_list => (tags ? tags.split(", ") : nil),
#                              :share_type_attributes => (share_type ? share_type.split(",") : nil),
#                              :author_id => (@people && @people[author] ? @people[author].id : Person.first.id),
#                              :valid_until => 3.months.from_now,
#                              :visibility => "everybody"
#                             )
# end

Given /^there is rideshare (offer|request) from "([^"]*)" to "([^"]*)" by "([^"]*)"$/ do |type, origin, destination, author|
  @listing = Factory(:listing, :listing_type => type, 
                               :category => "rideshare",
                               :origin => origin,
                               :destination => destination,
                               :author => @people[author],
                               :communities => [Community.find_by_domain("test")],
                               :share_type => nil
                               )
end

Given /^that listing is closed$/ do
  @listing.update_attribute(:open, false)
end

Given /^visibility of that listing is "([^"]*)"$/ do |visibility|
  @listing.update_attribute(:visibility, visibility)
end

Given /^that listing is visible to members of community "([^"]*)"$/ do |domain|
  @listing.communities << Community.find_by_domain(domain)
end

Then /^There should be a rideshare (offer|request) from "([^"]*)" to "([^"]*)" starting at "([^"]*)"$/ do |share_type, origin, destination, time|
  listings = Listing.find_all_by_title("#{origin} - #{destination}")
end

When /^there is one comment to the listing from "([^"]*)"$/ do |author|
  @comment = Factory(:comment, :listing => @listing, :author => @people[author])
end

Then /^the total number of comments should be (\d+)$/ do |no_of_comments|
  Comment.all.count.should == no_of_comments.to_i
end

