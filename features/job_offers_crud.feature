Feature: Job Offers CRUD
  In order to get employees
  As a job offerer
  I want to manage my offers

  Background:
  	Given I am logged in as job offerer
    And I access the new offer page
    When I fill the title with "Programmer vacancy"
    
    
  Scenario: Create new offer
    And confirm the new offer    
    Then I should see "Offer created"
    And I should see "Programmer vacancy" in My Offers
    And I should see 30 days plus actual day in expired date in My Offers

  Scenario: Create new offer
    When I fill the expired date with "12-12-2015"
    And confirm the new offer    
    Then I should see "12-12-2015" in expired date in My Offers

  Scenario: Create new offer with salary option
    And I check salary expectations
    And confirm the new offer
    And an applicant apply
    Then I should see "Salary expectation"

  Scenario: Create new offer without salary option
    And I not check salary expectations
    And confirm the new offer
    And an applicant apply    
    Then I should not see "Salary Expectation"

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

  Scenario: Can't apply to my own offers
    Given an offer with the title "Programmer vacancy" created by me
    Given I access the job offers page
    Then I shouldn't see the "Apply" button on offers I created

  Scenario: I can apply to offers which are not mine
    Given an offer with the title "Programmer vacancy"
    Given I access the job offers page
    Then I should see the "Apply" button on offers I created
