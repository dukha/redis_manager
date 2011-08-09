#Given /^the application$/ do
  #pending # express the regexp above with the code you wish you had
#end

#When /^I start the application$/ do
  #pending # express the regexp above with the code you wish you had
  #visit app_path
#end
When /^I start the application with "([^"]*)"$/ do |app_path|
  #pending # express the regexp above with the code you wish you had
  visit app_path
end

Then /^I see "([^"]*)"$/ do |text|
  #pending # express the regexp above with the code you wish you had
  #within "#container" do
    has_content? text #"Home - Whiteboard"
  #end
end



Then /^the menu is opened at Translations$/ do
  pending # express the regexp above with the code you wish you had
end

