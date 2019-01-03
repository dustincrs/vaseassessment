require 'test_helper'

class FileControllerTest < ActionDispatch::IntegrationTest
  test "should get download" do
    get file_download_url
    assert_response :success
  end

end
