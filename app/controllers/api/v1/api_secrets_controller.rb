class Api::V1::ApiSecretsController < ApplicationController
  def generate
    key = generate_unique_key

    @api_secret = ApiSecret.first
    @api_secret.destroy if @api_secret

    @api_secret = ApiSecret.new(key:)

    if @api_secret.save
      render json: { key: @api_secret.key }, status: :ok
    else
      render json: { errors: @api_secret.errors.full_messages }, status: :unprocessable_entity
    end
  end

  def existing_keys
    api_secrets = ApiSecret.all
    keys = api_secrets.pluck(:key)
    render json: { keys: keys }, status: :ok
  end

  private

  def generate_unique_key
    loop do
      key = SecureRandom.hex(32)
      return key unless ApiSecret.exists?(key:)
    end
  end
end
