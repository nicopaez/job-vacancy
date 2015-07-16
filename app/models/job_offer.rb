require_relative '../exceptions/InvalidDateException.rb'

class JobOffer
  include DataMapper::Resource

  # property <name>, <type>
  property :id, Serial
  property :title, String
  property :location, String
  property :description, String
  property :created_on, Date
  property :updated_on, Date
  property :is_active, Boolean, :default => true
  property :salary_expectation, Boolean
  property :expired_date, Date
  property :visit_count, Integer, :default => 0
  belongs_to :user

  validates_presence_of :title

  def addVisit
    self.visit_count = visit_count + 1
  end

  def owner
    user
  end

  def owner=(a_user)
    self.user = a_user
  end

  def self.all_active
    offers = JobOffer.all(:is_active => true)
    self.enumerate_equal_titles(offers)
  end

  def self.find_by_owner(user)
    offers = JobOffer.all(:user => user)
    self.enumerate_equal_titles(offers)
  end

  def self.deactivate_old_offers
    active_offers = JobOffer.all(:is_active => true)

    active_offers.each do |offer|
      if (Date.today - offer.updated_on) >= 30
        offer.deactivate
        offer.save
      end
    end
  end

  def activate
    self.is_active = true
  end

  def deactivate
    self.is_active = false
  end

  def refreshDate(date)
    if (date < Date.today)
      raise InvalidDateException
    end
    self.is_active = true
    self.updated_on = date
    self.save
  end

  def self.enumerate_equal_titles(list_of_offers)
    titles = Hash.new 0
    final_offers = Array.new
    offer_new = JobOffer.new 

    list_of_offers.each do
    |offer|
      exist = false
      clean_offer = offer.title.delete(' ').downcase
      
      
      titles.each_key do
      |title|
        if clean_offer == title
          exist = true
        end
      end

      if exist
        titles[clean_offer] = titles[clean_offer] + 1
        offer_new = offer.clone
        offer_new.title = offer.title + ' - #' +  titles[clean_offer].to_s
        final_offers.push(offer_new)
      else
        titles[clean_offer] = 1
        final_offers.push(offer)
      end
    end

    final_offers
  end

end

