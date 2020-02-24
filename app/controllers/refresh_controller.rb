class RefreshController < ApplicationController
  before_action :authorize_refresh_by_access_request!
  def create
    session = JWTSessions::Session.new(
      payload: payload,
      refresh_by_access_allowed: true
    )
    token = session.refresh_by_access_allowed do
      raise JWTSessions::Errors::Unauthorize, 'Something is wrong here'
    end
    response.set_cookie(
      JWTSessions.access_token,
      value: token[:access],
      httponly: true,
      secure: Rails.env.production?
    )
    render json: { csrf: tokens[:csrf] }, status: :ok
  end
end
