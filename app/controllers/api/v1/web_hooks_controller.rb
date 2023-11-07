class Api::V1::WebHooksController < ApplicationController
    def create
        @subscription = WebhookSubscription.new(subscription_params)
        if @subscription.save
            render json: { message: 'Webhook subscription created successfully', subscription: @subscription }, status: :created
        else
            render json: { errors: @subscription.errors }, status: :unprocessable_entity
        end
    end
 
    private

    def subscription_params
        params.permit(:url, :event_type)
    end
end
