Feature: Search E-Book
  As a user
  I want to be able to search for E-books

  Scenario: Search for E-book
    Given I am on Bifrost-Boeger searchpage
    When Search for "Testbog1" in "All Fields"
    Then I should see "Testbog1" in "Titel"
