Given(/^an offer with the title "(.*?)"$/) do |title|
  visit '/job_offers/new'
  fill_in('job_offer[title]', :with => title)
  click_button('Create')
end

When(/^I fill the title of a new offer with "(.*?)" and submit$/) do |title|
  visit '/job_offers/new'
  fill_in('job_offer[title]', :with => title)
  click_button('Create')
end

Then(/^I should see the title "(.*?)"$/) do |arg1|
  visit 'job_offers/my'
  page.should have_content(title)
end
