Given(/^only a "(.*?)" offer exists in the offers list$/) do | job_title |
  JobOffer.all.destroy
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
  click_link('Apply')
  fill_in('job_offer_applicant[applicant_email]', :with => 'applicant@test.com')
  fill_in('job_offer_applicant[name]', :with => 'Santiago')
  fill_in('job_offer_applicant[last_name]', :with => 'Ladavaz')
  fill_in('job_offer_applicant[link_to_cv]', :with => 'http://wwww.cv.com.ar')
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
  fill_in('job_offer_applicant[link_to_cv]', :with => 'dropbox.com')
  fill_in('job_offer_applicant[link_to_cv]', :with => 'http://wwww.cv.com.ar')
  fill_in('job_offer_applicant[applicant_email]', :with => '')
  fill_in('job_offer_applicant[name]', :with => '')
  fill_in('job_offer_applicant[last_name]', :with => '')
end

Given(/^I confirm$/) do
  click_button('Apply')
end

Then(/^I should see error message$/) do
  page.should have_content('Complete mandatory fields')
end