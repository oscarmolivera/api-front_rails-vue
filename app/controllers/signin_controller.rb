class SigninController < ApplicationController
  def create
    user = User.find_by(email: params[:email])

    if user.authenticate?
      payload = { user_id: user.id }
      session = JWTSessions::Session.new(
        payload: payload,
        refresh_by_access_allowed: true
      )
      token = session.login
      response.set_cookie(
        JWTSessions.access_token,
        value: token[:access],
        httponly: true,
        secure: Rails.env.production?
      )
      render json: { csrf: tokens[:csrf] }, status: :ok
    else
      not_authorized
    end
  end

  def destroy
    session = JWTSessions::Session.new(payload: payload)
    session.flush_by_by_access_paylod
    render json: {}, status: :ok
  end

  private

  def not_found
    render json: { error: 'can not find email/password combination'}, status: :not_found
  end
end