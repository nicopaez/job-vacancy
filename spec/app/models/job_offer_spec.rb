require 'spec_helper'
require_relative '../../../app/exceptions/InvalidDateException.rb'

describe JobOffer do

  describe 'model' do

    subject { @job_offer = JobOffer.new }

    it { should respond_to(:id) }
    it { should respond_to(:title) }
    it { should respond_to(:location) }
    it { should respond_to(:description) }
    it { should respond_to(:owner) }
    it { should respond_to(:owner=) }
    it { should respond_to(:created_on) }
    it { should respond_to(:updated_on) }
    it { should respond_to(:is_active) }
    it { should respond_to(:expired_date) }

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
      old_offer.refreshDate(Date.today)
      expect(old_offer.is_active).to eq true
    end

    it 'should raise an invalid date error when the given date is wrong' do
      expect { old_offer.refreshDate((Date.today - 5))
      }.to raise_error(InvalidDateException)
    end

  end

  describe 'create job offer' do
    let(:old_offer) do
      old_offer = JobOffer.new
      old_offer.title = "new title"
      old_offer.save
      old_offer
    end

    it 'should expired date be 12-12-2015' do
      old_offer.expired_date = Date.new(2015, 12, 12)
      expect(old_offer.expired_date).to eq Date.parse '12-12-2015'
    end
  end

  describe 'enumerate equal titles' do

    let(:camila) { User.create(name: 'Camila', password: '1234', email: 'camilagarcia.113@hotmail.com') }
    let(:an_offer) { JobOffer.create(title: 'Programmer Vacancy', user: camila, created_on: (Date.today - 5)) }

    before :each do
      JobOffer.all.destroy
      an_offer
    end

    it 'should add an - #2 at the end of the newest repeated title' do
      another_offer = JobOffer.create(title: 'Programmer Vacancy', user: camila, created_on: (Date.today))
      offers = JobOffer.all_active
      /puts offers[0].title
      puts offers[1].title/
      expect(offers[0].title).to eq("Programmer Vacancy")
      expect(offers[1].title).to eq("Programmer Vacancy - #2")
    end

		it 'should add an - #2 at the end of the newest repeated title even though it has more blank spaces' do
      another_offer = JobOffer.create(title: 'P r o g r a m m e r Vacancy', user: camila, created_on: (Date.today))
      offers = JobOffer.all_active
      expect(offers[0].title).to eq("Programmer Vacancy")
      expect(offers[1].title).to eq("P r o g r a m m e r Vacancy - #2")
    end

    it 'should add an - #2 at the end of the newest repeated title even though it has uppercase words' do
      another_offer = JobOffer.create(title: 'PROGRAMMER Vacancy', user: camila, created_on: (Date.today))
      offers = JobOffer.all_active
      expect(offers[0].title).to eq("Programmer Vacancy")
      expect(offers[1].title).to eq("PROGRAMMER Vacancy - #2")
    end



  end


end