When(/^I am logged as an user\.$/) do
  visit '/login'
  fill_in('user[email]', :with => 'offerer@test.com')
  fill_in('user[password]', :with => 'Passw0rd!')
  click_button('Login')
end

When(/^i go to my offers$/) do
  visit('/job_offers/my')
end

When(/^i have an expired offer$/) do
 visit '/job_offers/new'
 fill_in('job_offer[title]', :with => 'Expired Offer')
 click_button('Create')
 @job = JobOffer.first(:title => 'Expired Offer')
 @job.expired_date = Date.today - 3
 @job.save
end

When(/^i have a valid offer$/) do
 visit '/job_offers/new'
 fill_in('job_offer[title]', :with => 'Valid Offer')
 click_button('Create')
 @job2 = JobOffer.first(:title => 'Valid Offer')
 @job2.expired_date = Date.today + 30
 @job2.save
end

Given(/^an active offer$/) do
  visit('/job_offers/my')
  @cssAttributeCheck = page.find('span[class="icon-ok"]')['class']
end

Then(/^i should see a check image$/) do
  @cssAttributeCheck.should eq 'icon-ok'
  @job2.destroy
end

Given(/^an expired offer$/) do
  visit('/job_offers/my')
  @cssAttributeCross = page.find('span[class="icon-remove"]')['class']
end

Then(/^i should see a cross image$/) do
  @cssAttributeCross.should eq 'icon-remove'
  @job.destroy
end

