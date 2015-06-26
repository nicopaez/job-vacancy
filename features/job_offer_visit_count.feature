Feature: Counting the number of visits in  a job offer

  Scenario: New offer has no visits
    Given I create a new offer
    When I visit my offers page
    Then I should see that the offer has zero visits

   Scenario: Offer visited 
    Given I visit an offer
    When I visit my offers page
    Then I should see that the offer's been visited 1 times