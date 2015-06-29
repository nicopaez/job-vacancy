When(/^I browse the default page$/) do
  visit '/'
end

Given(/^I am logged in as job offerer$/) do
  JobOffer.all.destroy
  visit '/login'
  fill_in('user[email]', :with => 'offerer@test.com')
  fill_in('user[password]', :with => 'Passw0rd!')
  click_button('Login')
  page.should have_content('offerer@test.com')
end

Given(/^I access the new offer page$/) do
  JobOffer.all.destroy
  visit '/job_offers/new'
  page.should have_content('Title')
  page.should have_content('Salary')
end

When(/^I fill the title with "(.*?)"$/) do |offer_title|
  fill_in('job_offer[title]', :with => offer_title)
end

When(/^I check salary expectations$/) do
  check('job_offer[salary_expectation]')
end

When(/^confirm the new offer$/) do
  click_button('Create')
end

When(/^I fill the expired date with "(.*?)"$/) do |date|
  fill_in('expired_date', :with => (Date.parse date))
end


When(/^an applicant apply$/) do
  visit '/'
  click_link('Logout')
  visit '/job_offers/latest'
  click_link('Apply')
end

When(/^I not check salary expectations$/) do
  uncheck('job_offer[salary_expectation]')
end

Given(/^I have "(.*?)" offer in My Offers$/) do |offer_title|
  JobOffer.all.destroy
  visit '/job_offers/new'
  fill_in('job_offer[title]', :with => offer_title)
  click_button('Create')
end

Given(/^I edit it$/) do
  click_link('Edit')
end

And(/^I delete it$/) do
  click_button('Delete')
end

Given(/^I set title to "(.*?)"$/) do |new_title|
  fill_in('job_offer[title]', :with => new_title)
  fill_in('expired_date', :with => '30/10/2020')
end

Given(/^I save the modification$/) do
  click_button('Save')
end


Given(/^an offer with the title "(.*?)" created by me$/) do |title|
  JobOffer.all.destroy
  visit '/job_offers/new'
  fill_in('job_offer[title]', :with => title)
  click_button('Create')
end

Given(/^I access the job offers page$/) do
  visit '/job_offers/latest'
end

Then(/^I shouldn't see the "(.*?)" button on offers I created$/) do |arg1|
  page.has_no_button?('Apply')
end

Then(/^I should see the "(.*?)" button on offers I created$/) do |arg1|
  page.has_button?('Apply')
end

Then(/^I should see (\d+) days plus actual day in expired date in My Offers$/) do |arg1|
  visit '/job_offers/my'
  page.should have_content(Date.today + arg1.to_i)
end

Then(/^I should see "(.*?)" in expired date in My Offers$/) do |date|
  visit '/job_offers/my'
  page.should have_content(Date.parse date)
end

Then(/^I should see "(.*?)" in My Offers$/) do |content|
  visit '/job_offers/my'
  page.should have_content(content)
end


Then(/^I should not see "(.*?)" in My Offers$/) do |content|
  visit '/job_offers/my'
  page.should_not have_content(content)
end


Given(/^an active offer$/) do
  visit '/job_offers/new'
  fill_in('job_offer[title]', :with => 'Valid Offer')
  click_button('Create')
  @job2 = JobOffer.first(:title => 'Valid Offer')
  @job2.expired_date = Date.today + 30
  @job2.save
  visit('/job_offers/my')
  @cssAttributeCheck = page.find('span[class="icon-ok"]')['class']
end

Then(/^i should see a check image$/) do
  @cssAttributeCheck.should eq 'icon-ok'
  @job2.destroy
end

Then(/^expiration date is highlighted with a green color in the view$/) do
  page.find('font[color="green"]')['color'].should eq 'green'
end

Given(/^an expired offer$/) do
  visit '/job_offers/new'
  fill_in('job_offer[title]', :with => 'Expired Offer')
  click_button('Create')
  @job = JobOffer.first(:title => 'Expired Offer')
  @job.expired_date = Date.today - 3
  @job.save
  visit('/job_offers/my')
  @cssAttributeCross = page.find('span[class="icon-remove"]')['class']
end

Then(/^i should see a cross image$/) do
  @cssAttributeCross.should eq 'icon-remove'
  @job.destroy
end

Then(/^expiration date is highlighted with a red color in the view$/) do
  page.find('font[color="red"]')['color'].should eq 'red'
end
