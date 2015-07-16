Given(/^an expired job named "(.*?)"$/) do |expiredJob|
  JobOffer.all.destroy
  visit '/login'
  fill_in('user[email]', :with => 'offerer@test.com')
  fill_in('user[password]', :with => 'Passw0rd!')
  click_button('Login')
  visit '/job_offers/new'
  fill_in('job_offer[title]', :with => expiredJob)
  click_button('Create')
  job = JobOffer.first(:title => expiredJob)
  job.expired_date = Date.today - 3
  job.save
  click_link('Edit')
end

Given(/^a post date$/) do
  fill_in('expired_date', :with => '30/10/2020')
end

When(/^accept the action$/) do
   click_button('saveButton')
end

Then(/^"(.*?)" is updated$/) do |expiredOffer|
  page.should have_content(expiredOffer)
  page.should have_content('2020-10-30')
end

Given(/^an invalid date$/) do
 fill_in('expired_date', :with => '30/10/2005')
end

Then(/^an error of "(.*?)" it's shown$/) do |error|
  page.should have_content(error)
end
