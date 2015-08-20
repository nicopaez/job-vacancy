Feature: Applicants List
  As a job offerer
  I want to see the applicant's info

 Scenario: An applicant apply to an offer
  Given an active offers
  And an user who apply that offer
  Then i should see him in my list of applicants of that offer