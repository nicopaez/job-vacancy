require 'uri'

class JobOfferApplicant
  include DataMapper::Resource

  # property <name>, <type>
  property :id, Serial
  property :name, String
  property :last_name, String
  property :salary_expectations, Integer
  property :applicant_email, String
  property :link_to_cv , String, :format => :url
  property :offer_id, Integer 

  validates_presence_of :name, :message => "Name is mandatory"
  validates_presence_of :last_name, :message => "Last Name is mandatory"
  validates_presence_of :applicant_email, :message => "Email is mandatory"
  validates_presence_of :salary_expectations, :message => "Salary expectations is mandatory"
  validates_presence_of :link_to_cv, :message => "Link to CV is mandatory"
  validates_format_of :link_to_cv, :as => :url, :message => "CV must be a valid link"

  self.raise_on_save_failure = true

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
