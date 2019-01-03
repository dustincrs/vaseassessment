require 'test_helper'

class WelcomeControllerControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get welcome_controller_index_url
    assert_response :success
  end

end
