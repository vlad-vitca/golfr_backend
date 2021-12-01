# Base class for Rails controllers
class ApplicationController < ActionController::API
  include Devise::Controllers::Helpers

  def logged_in!
    return if current_user.present?

    render json: {
      errors: [
        'User not logged in'
      ]
    }, status: :unauthorized
  end

  def user_by_id(id)
    user = User.find_by(id: id)

    if user.blank?
      render json: {
        errors: [
          "User with id #{id} not found"
        ]
      }, status: :not_found
      return
    end

    return user
  end


  def current_token
    request.env['warden-jwt_auth.token']
  end
end
