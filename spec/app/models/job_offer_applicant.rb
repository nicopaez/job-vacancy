require 'spec_helper'
require_relative '../../../app/exceptions/InvalidDateException.rb'

describe JobOfferApplicant do

  describe 'model' do

    subject { @job_offer = JobOfferApplicant.new }

    it { should respond_to(:id) }
    it { should respond_to(:name) }
    it { should respond_to(:last_name) }
    it { should respond_to(:salary_expectations) }
    it { should respond_to(:applicant_email) }
    it { should respond_to(:link_to_cv) }
  end
end