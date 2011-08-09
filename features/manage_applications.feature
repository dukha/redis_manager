Feature: Admin manages application to be translated

  As an admin
  I want to add, update, view  and delete a new application
  So that it can be translated

  Scenario: View all applications
    When I click Applications in the menu
    Then I see a list of all applications to be or have been translated
    And I see a New Application link

  Scenario: Add a new application
    Given that the application is not in the database
    When I click Applications in the menu
    Then I see a New Application link

