Feature: Offers with expiration date

  Scenario:Don't see expired offer in List offer
    Given I access the Job offers page
    Given I have an expired offer
    Then I should not see the offer in that page
