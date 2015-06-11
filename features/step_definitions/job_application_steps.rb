Given(/^only a "(.*?)" offer exists in the offers list$/) do | job_title |
  @job_offer = JobOffer.new
  @job_offer.owner = User.first
  @job_offer.title = job_title
  @job_offer.location = 'a nice job'
  @job_offer.description = 'a nice job'
  @job_offer.expired_date = Date.today + 30
  @job_offer.save
end

Given(/^I access the offers list page$/) do
  visit '/job_offers'
end

When(/^I apply$/) do
  click_link 'Apply'
  fill_in('job_application[applicant_email]', :with => 'applicant@test.com')
  click_button('Apply')
end

When(/^I apply to an offer$/) do
  click_link('Apply', match: :first)
end


Then(/^I should receive a mail with offerer info$/) do
  mail_store = "#{Padrino.root}/tmp/emails"
  file = File.open("#{mail_store}/applicant@test.com", "r")
  content = file.read
  content.include?(@job_offer.title).should be true
  content.include?(@job_offer.location).should be true
  content.include?(@job_offer.description).should be true
  content.include?(@job_offer.owner.email).should be true
  content.include?(@job_offer.owner.name).should be true
end

Then(/^I should see "(.*?)" field$/) do |field|
  page.should have_content(field)
end


Given(/^I don't fill mandatory field$/) do
  fill_in('job_application[applicant_email]', :with => '')
end

Given(/^I confirm$/) do
  click_button('Apply')
end

Then(/^I should see error message$/) do
  page.should have_content('Complete mandatory fields')
end

