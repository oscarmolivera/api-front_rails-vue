class ApplicationController < ActionController::API
  include JWTSession::RailsAuthorization
  rescue_from JWTSession::Errors::Unauthorized, with: :not_authorized

  private

  def current_user
    @current_user ||= User.find(payload['user_id'])
  end

  def not_authorized 
    render json: {error: 'not authorized'}, status: :unauthorized
  end
end
