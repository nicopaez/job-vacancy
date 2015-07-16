
Feature: Search offers by description
  As an user
  I want to look up for offers by their title and description

  Background:
    Given I access the job offers page
    Given there is a job offer with title "Programmer" and description "Good job"
    Given there is a job offer with title "Java" and description "Nice job"

  Scenario: An user looks up for an existing offer by the description
    Given I write "Good job" on the search bar and press search
    Then I should see the offer with description "Good job"

  Scenario: An user looks up for a not existing offer by the description
    Given I write "Excelent job" on the search bar and press search
    Then I should't see any offers with description "Excelent job"

  Scenario: An user looks up for an existing offer by title
    Given I write "Programmer" on the search bar and press search
    Then I should see the offer with title "Programmer"

  Scenario: An user looks up for a not existing offer by title
    Given I write "Tester" on the search bar and press search
    Then I should't see any offers with title "Tester"