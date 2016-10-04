class ApplicationController < ActionController::API
  include DeviseTokenAuth::Concerns::SetUserByToken
  # before_action :configure_permitted_parameters, if: :devise_controller?
  respond_to :json
end
