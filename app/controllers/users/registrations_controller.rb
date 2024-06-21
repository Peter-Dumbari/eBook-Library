class Users::RegistrationsController < Devise::RegistrationsController
  respond_to :json
  before_action :check_user_existence, only: [:create]

  private

  def check_user_existence
    user = User.find_by(email: sign_up_params[:email])
    return unless user

    render json: { message: 'User with this email already exists, try another one' }, status: :unprocessable_entity
  end

  def respond_with(resource, _options = {})
    if resource.persisted?
      render json: {
        status: { code: 200, message: 'Signed up Successfully',
                  data: resource }
      }, status: :ok
    else
      render json: {
        status: { message: 'User could not be created successfully',
                  errors: resource.errors.full_messages }
      }
    end
  end
end
