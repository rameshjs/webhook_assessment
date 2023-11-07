class WebhookSubscription < ApplicationRecord

    validates :event_type, presence: true, inclusion: { in: %w(on_create, on_update), message: "Invalid available events on_create and on_update" }
    validates :url, presence: true, uniqueness: {
        scope: :event_type, message: -> (_object, data){ "Event type already exists for #{data[:value]}" }
    }

    

    validate :https_urls

    def https_urls
        #To validate url format
        if url.blank? || !url.match?(URI::DEFAULT_PARSER.make_regexp(%w[http https]))
            errors.add(:url, "Invalid url format")
        else
    end
        rescue URI::InvalidURIError
        errors.add(:url, "Invalid url format")
    end
end
