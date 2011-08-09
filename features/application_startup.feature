Feature: See the menu and whiteboard after login unless url specifies another destination after login
  

  As a user
  I want to see the menu
  If I login in with the standard calm_translator url, e.g http://calm_translator (but not http://calm_translator/translations
  As a user I want to see messages on the whiteboard after the applications starts

  @mwip @app_start
  Scenario: I see the whiteboard
    Given I am on the home page
    #When I start the application with "app_path"
    Then I see "Home - Whiteboard"
  @mwip
  Scenario: I see the menu
    #When I start the application with "app_path"
    Given I am on the home page
    Then I see "Translations"
    #And the menu shows "Applications"