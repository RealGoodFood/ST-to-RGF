Feature: User views a single listing
  In order to value
  As a role
  I want feature

  @javascript
  @only_without_asi
  Scenario: User views a listing that he is allowed to see
    Given there are following users:
      | person | 
      | kassi_testperson1 |
      | kassi_testperson2 |    
    And there is favor request with title "Massage" from "kassi_testperson1"
    And I am on the home page
    When I follow "Massage"
    Then I should see "Service request: Massage"
    And I should see "Requested by"
    And I should not see "Feedback:"
    And I should not see "Contact by phone"
    When I am logged in as "kassi_testperson1"
    And I have "2" testimonials with grade "0.5"
    And I am on the home page
    And I follow "Massage"
    Then I should see "Contact by phone"
    And I should see "Feedback:"
    And I should see "100%"
    And I should see "(2/2)"
    And I should see "Add profile picture"
    When I follow "Settings"
    And I follow "Profile picture"
    And I attach a valid image file to "avatar_file"
    And I press "Save picture"
    And I go to the home page
    And I follow "Massage"
    Then I should not see "Add profile picture"
  
  @javascript
  Scenario: User tries to view a listing restricted viewable to community members without logging in
    Given I am not logged in
    And there is favor request with title "Massage" from "kassi_testperson1"
    And visibility of that listing is "this_community"
    And I am on the home page
    When I go to the listing page
    Then I should see "You must log in to view this content"
  
  @subdomain2
  @javascript
  Scenario: User tries to view a listing from another community
    Given I am not logged in
    And there is favor request with title "Massage" from "kassi_testperson1"
    And I am on the home page
    When I go to the listing page
    Then I should see "This content is not available in this community."
  
  @javascript
  Scenario: User belongs to multiple communities, adds listing in one and sees it in another
    Given I am not logged in
    And there is favor request with title "Massage" from "kassi_testperson1"
    And visibility of that listing is "this_community"
    And I am on the home page
    When I go to the listing page
    Then I should see "You must log in to view this content"
  
  
  
