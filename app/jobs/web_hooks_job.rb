require 'http'

class WebHooksJob < ApplicationJob
  queue_as :default
  sidekiq_options retry: 2, dead: false

  def perform(subscription, payload)
    return if
    subscription.nil?

    webhook_endpoint = subscription.url
    return if
      webhook_endpoint.nil?

    response = HTTP.timeout(30)
                   .headers(
                     'Content-Type' => 'application/json',
                     'X-Verify-Token-SHA256' => verification_header(
                       payload:
                     )
                   )
                   .post(
                     webhook_endpoint,
                     body: {
                       event: subscription.event_type,
                       payload:
                     }.to_json
                   )

    return unless response.status.success?

    nil
  rescue HTTP::TimeoutError
    Sidekiq.logger.info('Timeout error')
  rescue HTTP::ConnectionError
    Sidekiq.logger.info('Connection error')
  rescue OpenSSL::SSL::SSLError
    Sidekiq.logger.info('TLS error')
  end

  def verification_header(payload:)
    string_to_sign = Digest::MD5.hexdigest(payload.to_json)
    api_secret = ApiSecret.first

    if api_secret.nil?
      generate_secret
      api_secret = ApiSecret.first
    end

    secret = api_secret.key
    hmac_digest = OpenSSL::HMAC.hexdigest('sha256', secret, string_to_sign)
    Base64.strict_encode64(hmac_digest)
  end

  def generate_secret
    key = SecureRandom.hex(32)
    api_secret = ApiSecret.new(key:)
    api_secret.save
  end
end
