Given(/^there is a job offer with title "(.*?)" and description "(.*?)"$/) do |title, description|
  visit '/job_offers/new'
  fill_in('job_offer[title]', :with => title)
  fill_in('job_offer[description]', :with => description)
  click_button('Create')
end

Given(/^I write "(.*?)" on the search bar and press search$/) do |search|
  visit '/job_offers/latest'
  page.fill_in('search-input', :with => search)
  click_button('search')
end

Then(/^I should see the offer with description "(.*?)"$/) do |description|
  visit '/job_offers/latest'
  page.has_content?(description)
end

Then(/^I should't see any offers$/) do
  pending # express the regexp above with the code you wish you had
end

Then(/^I should see the offer with title "(.*?)"$/) do |arg1|
  pending # express the regexp above with the code you wish you had
end

