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

Given(/^I visit an offer$/) do
  visit '/job_offers'
  click_link('Apply')
  visit '/login'
  fill_in('user[email]', :with => 'santi@hotmail.com')
  fill_in('user[password]', :with => '1234')
  click_button('Login')
  page.should have_content('santi@hotmail.com')
end

When(/^I visit my offers page$/) do
  visit 'job_offers/my'
end

Then(/^I should see that the offer has zero visits$/) do
  page.should have_content('0')
end

Then(/^I should see that the offer's been visited (\d+) times$/) do |arg1|
  page.should have_content(arg1.to_s)
end
