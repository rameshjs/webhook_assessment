class CreateWebhookSubscriptions < ActiveRecord::Migration[7.1]
  def change
    create_table :webhook_subscriptions do |t|
      t.string :url, null: false
      t.string :event_type, null: false

      t.timestamps
    end
  end
end
