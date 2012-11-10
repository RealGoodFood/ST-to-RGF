Feature: User sends a new message
  In order to contact another user to ask about details related to a listing or just to chat
  As a user
  I want to be able to send a private message to another users
  
  @javascript
  Scenario: Asking details about a listing
    Given there are following users:
      | person | 
      | kassi_testperson1 |
      | kassi_testperson2 |
    And there is item offer with title "Hammer" from "kassi_testperson1" and with share type "lend"
    And I am logged in as "kassi_testperson2"
    And I am on the homepage
    When I follow "Hammer"
    And I follow "Send private message to lender"
    And I fill in "Title:" with "Question about the hammer"
    And I fill in "Message:" with "What kind of hammer is this?"
    And I press "Send message"
    Then I should see "Message sent" within "#notifications"
    And I should see "Lending: Hammer" within "h1"
    When I follow "Messages"
    And I follow "Sent"
    Then I should see "Question about the hammer"
    And I should see "What kind of hammer is this?"
    And I should not see "Awaiting confirmation from listing author"
    When I follow "Logout"
    And I log in as "kassi_testperson1"
    And I follow "Messages"
    Then I should not see "Accept"
    When I follow "Question about the hammer"
    Then I should not see "Accept"
  
  @javascript
  Scenario: Trying to ask details about a listing with inadequate information
    Given there are following users:
      | person | 
      | kassi_testperson1 |
      | kassi_testperson2 |
    And there is item offer with title "Hammer" from "kassi_testperson1" and with share type "lend"
    And I am logged in as "kassi_testperson2"
    And I am on the homepage
    When I follow "Hammer"
    And I follow "Send private message to lender"
    And I press "Send message"
    Then I should see "This field is required."
  
  @javascript
  Scenario: Asking details about a listing through the listing author box link
    Given there are following users:
      | person | 
      | kassi_testperson1 |
      | kassi_testperson2 |
    And there is item offer with title "Hammer" from "kassi_testperson1" and with share type "lend"
    And I am logged in as "kassi_testperson2"
    And I am on the homepage
    When I follow "Hammer"
    And I follow "message_listing_author_link"
    Then I should see "Send message to"
  
  @javascript
  Scenario: Sending message to a commenter
    Given there are following users:
      | person | 
      | kassi_testperson1 |
      | kassi_testperson2 |
    And there is item offer with title "Hammer" from "kassi_testperson1" and with share type "lend"
    And there is one comment to the listing from "kassi_testperson2"
    And I am logged in as "kassi_testperson1"
    And I am on the homepage
    When I follow "Hammer"
    And I should not see "free_message_link"
    And I follow "Send private message to" within "#comments"
    Then I should see "Send message to"
   
  @javascript
  Scenario: Sending message from the profile page
    Given there are following users:
      | person | 
      | kassi_testperson1 |
      | kassi_testperson2 |
    And I am logged in as "kassi_testperson2"
    And I am on the profile page of "kassi_testperson1"
    When I follow "Contact"
    And I fill in "Title:" with "Random title"
    And I fill in "Message:" with "Random message"
    And I press "Send message"
    Then I should see "Message sent" within "#notifications"
    When I follow "Messages"
    And I follow "Sent"
    Then I should see "Random title"
    And I should see "Random message"
    And I should not see "Awaiting confirmation from listing author"
    When I follow "Logout"
    And I log in as "kassi_testperson1"
    And I follow "Messages"
    Then I should not see "Accept"
    When I follow "Random title"
    Then I should not see "Accept"