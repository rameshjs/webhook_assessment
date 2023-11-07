# Webhook

This is a basic guide to set up your Ruby on Rails project. It covers database creation, migration, running the server, and starting Sidekiq for background job processing. Additionally, you'll find API endpoint and payload examples below.

## Prerequisites

- Ruby 3.2.2
- Ruby on Rails
- This project uses sqlite no config needed for demo.
- Redis (for Sidekiq)

## Getting Started

1. **Install Ruby dependencies:**

   ```sh
   bundle install

2. **Create the PostgreSQL database:**

   ```sh
   rails db:create
3. **Run database migrations:**

   ```sh
   rails db:migrate
4. **Start the Rails server:**

   ```sh
   rails s
5. **In a new terminal, start Sidekiq for background job processing ( make sure redis is installed ):**

   ```sh
   sidekiq

# Webhooks API Documentation

This API allows you to subscribe to webhooks for specific events. You can use the provided endpoint to create webhook subscriptions.

## Subscribe to an event

- **URL:** `http://localhost:3000/api/v1/webhooks/create`
- **Method:** `POST`

## Request

To subscribe to a webhook, send a POST request with the following payload:

```json
{
  "url": "https://webhook.site/aee6156e-25b3-4d6e-91e9-9e23e0665c72",
  "event_type": "update"
}
```
- url (string, required): The URL to which the webhook events will be sent.
- event_type (string, required): The type of event you want to subscribe to. There are two possible event types: `create` or `update`.

## Create a Secret Key

Before triggering events, you must create a secret key for secure event verification. To create a secret key, use the following endpoint:

- **URL:** `http://localhost:3000/api/v1/api_secrets/create`
- **Method:** `GET`

This endpoint does not require any request payload. When you send a GET request to this endpoint, it will generate a new secret key.

## Response

Upon successfully generating a secret key, you will receive a response with the created secret key, Which can be used in future to verify the events received.

Example response:

```json
{
  "key": "your_generated_secret_key_here"
}
```
## Create User

To create a new user, send a POST request to the following endpoint:

- **URL:** `http://localhost:3000/api/v1/users/create`
- **Method:** `POST`

Request Body:
```json
{
  "email": "test1@email.com",
  "first_name": "test",
  "last_name": "test"
}
```

## Update User

To update a user, send a PUT request to the following endpoint:

- **URL:** `http://localhost:3000/api/v1/users/:id`
- **Method:** `PUT`

Request Body:
```json
{
  "email": "test1@email.com",
  "last_name": "updated last name"
}
```

Above two endpoints will trigger webhook events.
