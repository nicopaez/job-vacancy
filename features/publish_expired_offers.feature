Feature:  publish expired offers
 
 
 Scenario: publish a selected expired offer
  Given an expired job named "expiredOffer" 
  And a post date
  When accept the action
  Then "expiredOffer" is updated

 
 Scenario: publish an expired jobs with an incorrect date
  Given an expired job named "expiredOffer"
  And an invalid date
  When accept the action
  Then an error of "Invalid date" it's shown