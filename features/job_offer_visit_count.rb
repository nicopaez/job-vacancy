Given(/^I create a new offer$/) do
	@santi = User.create(name: 'Santiago', password: '1234', email: 'santi@hotmail.com')
  @santi.save

  JobOffer.all.destroy
  @job_offer = JobOffer.new
  @job_offer.owner = @santi
  @job_offer.title = 'Java'
  @job_offer.location = 'a nice job'
  @job_offer.description = 'a nice job'
  @job_offer.expired_date = Date.today + 30
  @job_offer.save
end

When(/^I visit my offers page$/) do
  visit 'job_offers/my'
end

Then(/^I should see that the offer has zero visits$/) do
  page.should have_content('0')
end