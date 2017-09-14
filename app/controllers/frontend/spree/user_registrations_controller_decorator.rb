class Spree::UserRegistrationsController < Devise::RegistrationsController
  helper 'spree/base'

  include Spree::Core::ControllerHelpers::Auth
  include Spree::Core::ControllerHelpers::Common
  include Spree::Core::ControllerHelpers::Order
  include Spree::Core::ControllerHelpers::Store

  before_action :check_permissions, only: [:edit, :update]
  skip_before_action :require_no_authentication
  
  # GET /resource/sign_up
  def new
    super
    @user = resource
  end

  # POST /resource/sign_up
  def create
    
    if params["authenticity_token"].present?
      
      @user = build_resource(spree_user_params)
      uri = URI('http://localhost:3000/api/signup')
      res = Net::HTTP.post_form(uri, 'email' => @user.email, "password" => @user.password)
      resource_saved = @user.save
      yield resource if block_given?
      if resource_saved
        if resource.active_for_authentication?
          set_flash_message :notice, :signed_up
          sign_up(resource_name, resource)
          session[:spree_user_signup] = true
          respond_with resource, location: after_sign_up_path_for(resource)
        else
          set_flash_message :notice, :"signed_up_but_#{resource.inactive_message}"
          expire_data_after_sign_in!
          respond_with resource, location: after_inactive_sign_up_path_for(resource)
        end
      else
        clean_up_passwords(resource)
        render :new
      end
    else
      data = JSON.parse params["spree_user"].gsub('=>', ':')
      @user = Spree::User.create(:email=>data["email"], :password=>data["password"], :password_confirmation=>data["password_confirmation"])
    end
  end

  protected

  def check_permissions
    authorize!(:create, resource)
  end

  def translation_scope
    'devise.user_registrations'
  end

  private

  def spree_user_params
    params.require(:spree_user).permit(Spree::PermittedAttributes.user_attributes)
  end
end