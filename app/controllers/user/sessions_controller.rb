class User::SessionsController < ApplicationController
    response_to :json

    private

    def response_with(resource, _options={})
        unless resource.persisted?
            render json: 'Sign in not succesful!', status: :unauthorized
            return
        end
    
        render json: {
            status: { code: 200, message: 'Signed in Successfully',
                    data: resource }
        }, status: :ok
    end


    def response_to_on_destroy
        jwt_payload = JWT.decode(request.headers['Authorization'].split(1), Rails.application.credentials.fetch(:secret_key_base)).first

        current_user = User.find(jwt_payload["sub"])

        if current_user
            render json: {
              status: 200,
              message: 'Signed out successfully'
            }, status: :ok
          else
            render json: {
              status: 401,
              message: 'User has no active session'
            }, status: :unauthorized
          end
    end
end
