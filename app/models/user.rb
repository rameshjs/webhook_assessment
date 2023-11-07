class User < ApplicationRecord
  validates :email, presence: true, uniqueness: true
  validates :email, format: { with: URI::MailTo::EMAIL_REGEXP }
  validates :first_name, presence: true
  validates :last_name, presence: true

  after_create :call_service_on_create
  after_update :call_service_on_update

  private

  def call_service_on_create
    BroadcastWebhookService.new(event_type: 'create', payload: self).broadcast_event
  end

  def call_service_on_update
    BroadcastWebhookService.new(event_type: 'update', payload: self).broadcast_event
  end
end
