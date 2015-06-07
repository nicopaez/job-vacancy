require 'spec_helper'
require_relative '../../../app/exceptions/InvalidDateException.rb'

describe JobOffer do

	describe 'model' do

		subject { @job_offer = JobOffer.new }

		it { should respond_to( :id) }
		it { should respond_to( :title ) }
		it { should respond_to( :location) }
		it { should respond_to( :description ) }
		it { should respond_to( :owner ) }
		it { should respond_to( :owner= ) }
		it { should respond_to( :created_on) }
		it { should respond_to( :updated_on ) }
		it { should respond_to( :is_active) }
		it { should respond_to( :expired_date) }

	end

	describe 'valid?' do

	  let(:job_offer) { JobOffer.new }

	  it 'should be false when title is blank' do
	  	puts job_offer.owner
	  	expect(job_offer.valid?).to eq false
	  end

	end

	describe 'deactive_old_offers' do

		let(:today_offer) do
			today_offer = JobOffer.new
			today_offer.updated_on = Date.today
			today_offer
		end

		let(:thirty_day_offer) do
			thirty_day_offer = JobOffer.new
			thirty_day_offer.updated_on = Date.today - 45
			thirty_day_offer
		end

		it 'should deactivate offers updated 45 days ago' do
			JobOffer.should_receive(:all).and_return([thirty_day_offer])
			JobOffer.deactivate_old_offers
			expect(thirty_day_offer.is_active).to eq false
		end

		it 'should not deactivate offers created today' do
			JobOffer.should_receive(:all).and_return([today_offer])
			JobOffer.deactivate_old_offers
			expect(today_offer.is_active).to eq true
		end
	end



	describe 'publish old offers ' do
		let(:old_offer) do
			old_offer = JobOffer.new
			old_offer.title = "new title"
			old_offer.updated_on = Date.today - 30
			old_offer.save
			old_offer
		end

		it 'should activate the offer when the given date it is valid' do
			old_offer.refresh(Date.today)
			expect(old_offer.is_active).to eq true
		end

		it 'should raise an invalid date error when the given date is wrong' do
			expect { old_offer.refresh( (Date.today - 5))
		}.to raise_error(InvalidDateException)
		end

	describe 'create job offer' do
		let(:old_offer) do
			old_offer = JobOffer.new
			old_offer.title = "new title"
			old_offer.save
			old_offer
		end

		it'should expired date be 30 days plus today' do
			expect(old_offer.expired_date).to eq Date.today + 30
		end
	end
 
 end

end
