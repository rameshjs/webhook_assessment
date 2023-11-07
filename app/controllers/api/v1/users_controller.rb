class Api::V1::UsersController < ApplicationController
    def create
        @user = User.new(user_params)
        if @user.save
            render json: { message: 'User created successfully', user: @user }, status: :created
        else
            render json: { errors: @user.errors }, status: :unprocessable_entity
        end
    end

    private

    def user_params
        params.permit(:email, :first_name, :last_name)
    end
end
