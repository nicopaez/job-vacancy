
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


  def offer
    job_offer
  end

  def offer=(job_offer)
    self.job_offer = job_offer
  end

end