When(/^I am logged as an user\.$/) do
  JobOffer.all.destroy
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
  job = JobOffer.first(:title => 'Expired Offer')
  job.expired_date = Date.today - 3
  job.save
end

When(/^i have a valid offer$/) do
  visit '/job_offers/new'
  fill_in('job_offer[title]', :with => 'Valid Job')
  click_button('Create')
end

Given(/^an active offer$/) do
  @cssAttributeCheck = page.find('span[class="icon-ok"]')['class']
end


Then(/^i should see a check image$/) do
  @cssAttributeCheck.should eq 'icon-ok'
end
