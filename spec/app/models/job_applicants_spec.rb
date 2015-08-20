require 'spec_helper'

describe JobOfferApplicant do

  describe 'model' do

    subject { @job_offer_applicant = JobOfferApplicant.new }

    it { should respond_to(:id) }
    it { should respond_to(:name) }
    it { should respond_to(:last_name) }
    it { should respond_to(:salary_expectations) }
    it { should respond_to(:applicant_email) }
    it { should respond_to(:link_to_cv) }
    it { should respond_to(:offer) }
    it { should respond_to(:offer=) }
  end

  describe 'valid?' do

    let(:applicant) { JobOfferApplicant.new }

    it 'should be false when name is blank' do
      expect(applicant.save).to eq false
    end

    it 'should be false when last name is blank' do
      applicant.name = 'Santi'
      expect(applicant.save).to eq false
    end

    it 'should be false when email is blank' do
      applicant.name = 'Santi'
      applicant.last_name = 'Ladavaz'
      expect(applicant.save).to eq false
    end

    it 'should be true when applicant has name,last name and email ' do
      applicant.name = 'Santi'
      applicant.last_name = 'Ladavaz'
      applicant.applicant_email = 'santi@hotmail.com'
      expect(applicant.save).to eq true
    end
  
  end

end