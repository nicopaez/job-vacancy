Feature: Job Application
  In order to get a job
  As a candidate
  I want to apply to an offer

  Background:
    Given only a "Web Programmer" offer exists in the offers list
    Given I access the offers list page
    

  Scenario: Apply to job offer
    When I apply
    Then I should receive a mail with offerer info

  Scenario: Browse apply page
    When I apply to an offer
    Then I should see "Name" field
    And I should see "Last name" field
    And I should see "Salary expectations" field
    And I should see "Email" field
    And I should see "Link to cv" field


  Scenario: Don´t fill mandatory field
    When I apply to an offer
    And I don't fill mandatory field
    And I confirm 
    Then I should see error message