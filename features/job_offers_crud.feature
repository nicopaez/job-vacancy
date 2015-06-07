Feature: Job Offers CRUD
  In order to get employees
  As a job offerer
  I want to manage my offers

  Background:
  	Given I am logged in as job offerer

  Scenario: Create new offer
    Given I access the new offer page
    When I fill the title with "Programmer vacancy"
    And confirm the new offer    
    Then I should see "Offer created"
    And I should see "Programmer vacancy" in My Offers
    And I should see 30 days plus actual day in expired date in My Offers

  Scenario: Create new offer
    Given I access the new offer page
    When I fill the title with "Programmer vacancy"
    When I fill the expired date with "12-12-2015"
    And confirm the new offer    
    Then I should see "12-12-2015" in expired date in My Offers

  Scenario: Update offer
    Given I have "Programmer vacancy" offer in My Offers
    And I edit it
    And I set title to "Programmer vacancy!!!"
    And I save the modification
    Then I should see "Offer updated"
    And I should see "Programmer vacancy!!!" in My Offers

  Scenario: Delete offer
    Given I have "Programmer vacancy" offer in My Offers
    Given I delete it
    Then I should see "Offer deleted"
    And I should not see "Programmer vacancy!!!" in My Offers
