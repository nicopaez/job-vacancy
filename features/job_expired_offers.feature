Feature: Offers with expiration date

  Scenario:Don't see expired offer in List offer
    Given I access the Job offers page
    Given I have an expired offer
    Then I should not see the offer in that page

  Scenario:See actual offer in List offer
  	Given I access the Job offers page
  	Given I have an actual offer
  	Then I should see the offer in that page
