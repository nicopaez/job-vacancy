Feature: Enumerate equal titles

Background:
  Given I access the new offer page
  Given an offer with the title "Programmer vacancy"

@wip 
Scenario: enumerate identical titles
  When I fill the title of a new offer with "Programmer vacancy" and submit
  Then I should see "Programmer vacancy - #2"

@wip
Scenario: enumerate equal titles but one has more spaces
  When I fill the title of a new offer with "  Programmer    vacancy" and submit
  Then I should see "Programmer vacancy - #2"

@wip
Scenario: enumerate equal titles but one has different casing
  When I fill the title of a new offer with "PROGRAMMER vacancy" and submit
  Then I should see "PROGRAMMER vacancy - #2"

