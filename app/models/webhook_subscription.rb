class WebhookSubscription < ApplicationRecord
  ALLOWED_STATUSES = %w[update create]

  validates :event_type, presence: true
  validates :url, presence: true, uniqueness: {
    scope: :event_type, message: ->(_object, data) { "Event type already exists for #{data[:value]}" }
  }

  validate :https_urls
  validate :valid_event_type

  def https_urls
    # To validate url format
    errors.add(:url, 'Invalid url format') if url.blank? || !url.match?(URI::DEFAULT_PARSER.make_regexp(%w[http https]))
  rescue URI::InvalidURIError
    errors.add(:url, 'Invalid url format')
  end

  def valid_event_type
    return if ALLOWED_STATUSES.include?(event_type)

    errors.add(:event_type, "must be one of #{ALLOWED_STATUSES.join(', ')}")
  end
end
