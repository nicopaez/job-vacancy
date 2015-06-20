Feature: Image in "Is active" column & expiration date shows with colour

Background:
  When I am logged as an user.
  And i have an expired offer
  And i have a valid offer
  And i go to my offers

Scenario: check image it's seen
  Given an active offer
  Then expiration date is highlighted with a green color in the view
  Then i should see a check image
  

Scenario: Cross image it's seen
  Given an expired offer
  Then expiration date is highlighted with a red color in the view
  Then i should see a cross image 
