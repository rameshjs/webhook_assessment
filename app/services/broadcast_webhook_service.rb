class BroadcastWebhookService
    
    def initialize(event_type:, payload:)
      @event_type = event_type
      @payload = payload
    end

    def broadcast_event
      @subscriptions = WebhookSubscription.where(event_type: @event_type)
      puts "asdasdsa"
      @subscriptions.each do |webhook_endpoint|
        WebHooksJob.perform_later(webhook_endpoint)
      end
    end
  end
  