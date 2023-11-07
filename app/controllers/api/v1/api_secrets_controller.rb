class Api::V1::ApiSecretsController < ApplicationController
  def create
    key = generate_unique_key

    @api_secret = ApiSecret.first_or_initialize
    @api_secret.key = key

    if @api_secret.save
      render json: { key: @api_secret.key }, status: :ok
    else
      render json: { errors: @api_secret.errors.full_messages }, status: :unprocessable_entity
    end
  end

  private

  def generate_unique_key
    loop do
      key = SecureRandom.hex(32)
      return key unless ApiSecret.exists?(key:)
    end
  end
end
