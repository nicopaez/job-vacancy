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
  @job_offer = JobOffer.new
  @job_offer.owner = User.first
  @job_offer.title = 'Title'
  @job_offer.location = 'Expired Offer'
  @job_offer.description = 'Expired Offer'
  @job_offer.expired_date = Date.today - 3
  @job_offer.save
end

When(/^i have a valid offer$/) do
  @job_offer = JobOffer.new
  @job_offer.owner = User.first
  @job_offer.title = 'Title'
  @job_offer.location = 'Valid Offer'
  @job_offer.description = 'Valid Offer'
  @job_offer.expired_date = Date.today + 30
  @job_offer.save
end

Given(/^an active offer$/) do
  @cssAttributeCheck = page.find('span[class="icon-ok"]')['class']
end


Then(/^i should see a check image$/) do
  @cssAttributeCheck.should eq 'icon-ok'
end
