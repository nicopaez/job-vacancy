Feature: Image in "Is active" column 

Background:
   When I am logged as an user.
   And i have an expired offer
   And i have a valid offer
   And i go to my offers

Scenario: check image it's seen
   Given an active offer
   Then i should see a check image

Scenario: Cross image it's seen
  Given an expired offer
  Then i should see a cross image 
