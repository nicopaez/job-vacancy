# Helper methods defined here can be accessed in any controller or view in the application

JobVacancy::App.helpers do

  def display_errors_for job_element
    flash.now[:error] = []
    job_element.errors.each { |error| flash.now[:error] << error.first }
    flash.now[:error] = flash.now[:error].join(', ')
  end
  
end

