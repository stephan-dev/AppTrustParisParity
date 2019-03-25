require 'test_helper'

class JobsControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get jobs_index_url
    assert_response :success
  end

  test "should get import" do
    get jobs_import_url
    assert_response :success
  end

end
