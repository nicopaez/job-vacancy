JobVacancy::App.controllers :job_offers do

  get :my do
    @offers = JobOffer.find_by_owner(current_user)
    render 'job_offers/my_offers'
  end

  get :index do
    @offers = JobOffer.all_active
    render 'job_offers/list'
  end

  get :new do
    @job_offer = JobOffer.new
    render 'job_offers/new'
  end

  get :latest do
    @offers = JobOffer.all_active
    render 'job_offers/list'
  end

  get :edit, :with => :offer_id do
    @job_offer = JobOffer.get(params[:offer_id])
    # ToDo: validate the current user is the owner of the offer
    render 'job_offers/edit'
  end

  get :applicants, :with => :offer_id do
    @applicants = JobOfferApplicant.find_by_offer(params[:offer_id])
    render 'job_offers/applicants'
  end

  get :apply, :with => :offer_id do

    @job_offer = JobOffer.get(params[:offer_id])
    @job_offer_applicant = JobOfferApplicant.new

    # ToDo: validate the current user is the owner of the offer
    render 'job_offers/apply'
  end

  post :search do
    @offers = JobOffer.all(:title.like => "%#{params[:q]}%") +
              JobOffer.all(:description.like => "%#{params[:q]}%")
    render 'job_offers/list'
  end

post :apply, :with => :offer_id do
    @job_offer = JobOffer.get(params[:offer_id])

    @job_offer_applicant = JobOfferApplicant.new(params[:job_offer_applicant])

    applicant_email = params[:job_offer_applicant][:applicant_email]
    @job_offer_applicant.offer_id = @job_offer.id
    
    if @job_offer_applicant.salary_expectations == ''
      @job_offer_applicant.salary_expectations = -1
    end

    if @job_offer_applicant.save
      @job_application = JobApplication.create_for(applicant_email, @job_offer)
      @job_application.process
      flash[:success] = 'Contact information sent.'
      redirect '/job_offers'
    else
     @job_offer_applicant.errors.keys.each do |key|
      @job_offer_applicant.errors[key].each do |error|
        puts "#{key} => #{error}"
      end
    end
      flash[:error] = "Complete mandatory fields"
      redirect "job_offers/apply/" + params[:offer_id].to_s
    end

  end

  post :create do
    @job_offer = JobOffer.new(params[:job_offer])
    begin
      param = params[:job_offer]
      date = param[:expired_date].to_datetime
      
      if @job_offer.expired_date.nil? 
        @job_offer.expired_date = Date.today + 30
        date = @job_offer.expired_date
      end

      @job_offer.refreshDate(date)

      @job_offer.owner = current_user
      if @job_offer.save
        if params['create_and_twit']
          TwitterClient.publish(@job_offer)
        end
        flash[:success] = 'Offer created'
        redirect '/job_offers/my'
      else
        flash.now[:error] = 'Title is mandatory'
        @job_offer.expired_date = ''
        render 'job_offers/new'
      end
    rescue Exception => e
      flash.now[:error] = 'Invalid date'
      render 'job_offers/new'
    end
  end

  post :update, :with => :offer_id do
    @job_offer = JobOffer.get(params[:offer_id])
    begin
      param = params[:job_offer]
      @job_offer.refreshDate(param[:expired_date].to_datetime)
      @job_offer.update(params[:job_offer])
      if @job_offer.save
        flash[:success] = 'Offer updated'
        redirect '/job_offers/my'
      else
        flash.now[:error] = 'Title is mandatory'
        render 'job_offers/edit'
      end
    rescue Exception => e
      flash.now[:error] = 'Invalid date'
      render 'job_offers/edit'
    end
  end

  put :activate, :with => :offer_id do
    @job_offer = JobOffer.get(params[:offer_id])
    @job_offer.activate
    if @job_offer.save
      flash[:success] = 'Offer activated'
      redirect '/job_offers/my'
    else
      flash.now[:error] = 'Operation failed'
      redirect '/job_offers/my'
    end
  end

  delete :destroy do
    @job_offer = JobOffer.get(params[:offer_id])
    if @job_offer.destroy
      flash[:success] = 'Offer deleted'
    else
      flash.now[:error] = 'Title is mandatory'
    end
    redirect 'job_offers/my'
  end

end