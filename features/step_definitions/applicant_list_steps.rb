Given(/^an active offers$/) do
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

Given(/^an user who apply that offer$/) do
  visit '/job_offers'
  click_link('Apply')
  fill_in('job_offer_applicant[applicant_email]', :with => 'santiagoladavaz@gmail.com')
  fill_in('job_offer_applicant[name]', :with => 'Santiago')
  fill_in('job_offer_applicant[last_name]', :with => 'Ladavaz')
  fill_in('job_offer_applicant[link_to_cv]', :with => 'http://wwww.cv.com.ar')
  click_button('Apply')
end

Then(/^i should see him in my list of applicants of that offer$/) do
  visit '/login'
  fill_in('user[email]', :with => 'santi@hotmail.com')
  fill_in('user[password]', :with => '1234')
  click_button('Login')
  
  visit 'job_offers/my'
  click_link('Applicants')
  page.should have_content('Santiago')
end
