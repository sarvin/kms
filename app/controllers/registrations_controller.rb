class RegistrationsController < Devise::RegistrationsController
  # http://stackoverflow.com/questions/5370164/disabling-devise-registration-for-production-environment-only

  def new
    flash[:info] = 'Registrations are not open yet, but please check back soon'
    redirect_to root_path
  end

  def create
    flash[:info] = 'Registrations are not open yet, but please check back soon'
    redirect_to root_path
  end
end
