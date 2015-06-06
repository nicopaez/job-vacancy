Given(/^I access the Job offers page$/) do
  visit '/job_offers'
end

Given(/^I have an expired offer$/) do
  @job_offer = JobOffer.new
  @job_offer.owner = User.first
  @job_offer.title = 'Java'
  @job_offer.location = 'a nice job'
  @job_offer.description = 'a nice job'
  @job_offer.expired_date = Date.today -30
  @job_offer.save
end

Then(/^I should not see the offer in that page$/) do
  page.should_not have_content('Java')
end


Given(/^I have an actual offer$/) do
 @job_offer = JobOffer.new
  @job_offer.owner = User.first
  @job_offer.title = 'Java'
  @job_offer.location = 'a nice job'
  @job_offer.description = 'a nice job'
  @job_offer.expired_date = Date.today + 1
  @job_offer.save
end

Then(/^I should see the offer in that page$/) do
  page.should have_content('Java')
end