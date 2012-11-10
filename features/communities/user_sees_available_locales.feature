Feature: User sees available locales
  In order to have relevant languages available in own community
  As a user
  I want to see only the relevant languages in the languages list
  
  @javascript
  Scenario: User comes to multiple locale community
    Given the test community has following available locales:
      | locale |
      | fi |
      | en |
    When I am on the home page
    Then I should see "English" within "#uniform-locale"
    Then I should see "Suomi" within "#uniform-locale"
    Then I select "English" from "locale"
    And I should see "Share with others!" within "#offer_something_button"
    And I select "Suomi" from "locale"
    Then I should see "Listaa taitosi ja tavarasi!" within "#offer_something_button"
    
  Scenario: User comes to single locale community
    Given the test community has following available locales:
      | locale |
      | en |
    When I am on the home page
    Then I should not see selector "#locale_select_padding"
    And I should see "Share with others!" within "#offer_something_button"
  
  @javascript
  Scenario: There are no locales in community settings
    Given the test community has following available locales:
      | locale |
    When I am on the home page
    Then I should see "English" within "#uniform-locale"
    Then I should see "Suomi" within "#uniform-locale"
    Then I select "English" from "locale"
    And I should see "Share with others!" within "#offer_something_button"
    And I select "Suomi" from "locale"
    Then I should see "Listaa taitosi ja tavarasi!" within "#offer_something_button"
  
  
  
