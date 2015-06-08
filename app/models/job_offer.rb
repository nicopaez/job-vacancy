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
  property :expired_date, Date, :default => Date.today + 30
  belongs_to :user

  validates_presence_of :title

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

    list_of_offers.each do
    |offer|
      an_offer_title = titles[offer.title]
      another_offer_title = titles[offer.title]
      if an_offer_title.eql? another_offer_title || equal_without_spaces?(an_offer_title, another_offer_title)
        titles[offer.title] = titles[offer.title] + 1
      end
    end

    list_of_offers.each do
    |offer|
      unless titles[offer.title] == 1
        title = offer.title
        offer.title = title + " - ##{titles[title]}"
        titles[title] = titles[title] - 1
      end
    end
  end

  def self.equal_without_spaces?(a_title, another_title)
    a_title.delete(' ').eql? another_title.delete(' ')
  end

end

