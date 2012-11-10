Feature: User creates a new listing
  In order to perform a certain task using an item, a skill, or a transport, or to help others
  As a person who does not have the required item, skill, or transport, or has them and wants offer them to others
  I want to be able to offer and request an item, a favor, a transport or housing
  
  Scenario: Creating a new item request successfully
    Given I am logged in
    And I am on the home page
    When I follow "Tell what you need!"
    And I follow "an item"
    And I should see "Request type*:"
    And I select "Buying" from "listing_share_type"
    And I fill in "listing_title" with "Sledgehammer"
    And I fill in "listing_description" with "My description"
    And I fill in "listing_tag_list" with "Tools, hammers"
    And I attach a valid image file to "listing_listing_images_attributes_0_image"
    And I press "Save request"
    Then I should see "Buying: Sledgehammer" within "h1"
    And I should see "Request created successfully" within "#notifications"
    And I should see the image I just uploaded
  
  @javascript
  Scenario: Creating a new item offer successfully
    Given I am logged in
    And I am on the home page
    When I follow "Share with others!"
    And I follow "an item"
    And I should see "Offer type*:"
    And I select "Lending" from "listing_share_type"
    And I fill in "listing_title" with "My offer"
    And I fill in "listing_description" with "My description"
    And I attach a valid image file to "listing_listing_images_attributes_0_image"
    And I press "Save offer"
    Then I should see "Lending: My offer" within "h1"
    And I should see "Offer created successfully" within "#notifications"
    And I should see the image I just uploaded
  
  @javascript
  Scenario: Creating a new service request successfully
    Given I am logged in
    And I am on the home page
    When I follow "Tell what you need!"
    And I follow "a service"
    And I should not see "Request type*:"
    And I fill in "listing_title" with "Massage"
    And I fill in "listing_description" with "My description"
    And I attach a valid image file to "listing_listing_images_attributes_0_image"
    And I press "Save request"
    Then I should see "Service request: Massage" within "h1"
    And I should see "Request created successfully" within "#notifications"
    And I should see the image I just uploaded
  
  @javascript  
  Scenario: Creating a new rideshare request successfully
    Given I am logged in
    And I am on the home page
    When I follow "Tell what you need!"
    And I follow "a ride"
    And I fill in "listing_origin" with "Otaniemi"
    And I fill in "listing_destination" with "Turku"
    And wait for 2 seconds
    And I press "Save request"
    Then I should see "Rideshare request: Otaniemi - Turku" within "h1"
    And I should see "Request created successfully" within "#notifications" 
  
  @javascript  
  Scenario: Trying to create a new request without being logged in
    Given I am not logged in
    And I am on the home page
    When I follow "Tell what you need!"
    Then I should see "You must log in to Sharetribe to create a new request." within "#notifications"
    And I should see "Log in to Sharetribe" within "h2"

  @javascript
  Scenario: Trying to create a new item request with insufficient information
    Given I am logged in
    And I am on the home page
    When I follow "Tell what you need!"
    And I follow "an item"
    And I attach an image with invalid extension to "listing_listing_images_attributes_0_image"
    And I select "31" from "listing_valid_until_3i"
    And I select "December" from "listing_valid_until_2i"
    And I select "2013" from "listing_valid_until_1i"
    And I press "Save request"
    Then I should see "This field is required."
    And I should see "You must select one." 
    And I should see "This date must be between current time and one year from now." 
    And I should see "The image file must be either in GIF, JPG or PNG format." 
    
  @javascript  
  Scenario: Trying to create a new rideshare request with insufficient information
    Given I am logged in
    And I am on the home page
    When I follow "Tell what you need!"
    And I follow "a ride"
    And I fill in "Origin" with "Test"
    And I choose "valid_until_select_date"
    And I select "31" from "listing_valid_until_3i"
    And I select "December" from "listing_valid_until_2i"
    And I select "2013" from "listing_valid_until_1i"
    And I press "Save request"
    Then I should see "This field is required."
    And I should see "Departure time must be between current time and one year from now." 

  @javascript
  Scenario: User creates a listing and sees it in another community
    Given there are following users:
      | person | 
      | kassi_testperson3 |
    And there is item request with title "Hammer" from "kassi_testperson3" and with share type "buy"
    And I am on the homepage
    Then I should see "Hammer"
    When I move to community "test2"
    And I am on the homepage
    Then I should not see "Hammer"
    And I log in as "kassi_testperson3"
    And I check "community_membership_consent"
    And I press "Join community"
    And the system processes jobs
    And I am on the homepage
    Then I should see "Hammer"