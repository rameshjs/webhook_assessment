class BroadcastWebhookService
  def initialize(event_type:, payload:)
    @event_type = event_type
    @payload = payload
  end

  def broadcast_event
    @subscriptions = WebhookSubscription.where(event_type: @event_type)
    @subscriptions.each do |subscription|
      WebHooksJob.perform_later(subscription, @payload)
    end
  end
end
