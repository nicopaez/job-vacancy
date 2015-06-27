require 'uri'

class JobOfferApplicant
  include DataMapper::Resource

  # property <name>, <type>
  property :id, Serial
  property :name, String
  property :last_name, String
  property :salary_expectations, Integer
  property :applicant_email, String
  property :link_to_cv, String 
  property :offer_id, Integer 

  validates_presence_of :name
  validates_presence_of :last_name
  validates_presence_of :applicant_email
  validates_presence_of :salary_expectations


  def offer
    job_offer
  end

  def offer=(job_offer)
    self.job_offer = job_offer
  end

  def self.find_by_offer(offer)
    offers = JobOfferApplicant.all(:offer_id => offer)
  end

  def url_valid?(url)
    url = URI.parse(url) rescue false
    url.kind_of?(URI::HTTP) || url.kind_of?(URI::HTTPS)
  end 

end