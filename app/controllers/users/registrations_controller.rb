class  Users::RegistrationsController < Devise::RegistrationsController
  protected

  def after_sign_up_path_for(resource_or_scope)
    '/profile/edit'
  end
  
  def create
    build_resource

    if resource.save
      set_flash_message :notice, :signed_up
      sign_in(resource_name, resource)
      redirect_to params[:after_sign_up_path] ||
  after_sign_in_path_for(resource)
    else
      clean_up_passwords(resource)
      render_with_scope :new
    end
  end
end