require "test_helper"

class Api::V1::ApiSecretsControllerTest < ActionDispatch::IntegrationTest
  test "should get create" do
    get api_v1_api_secrets_create_url
    assert_response :success
  end
end
