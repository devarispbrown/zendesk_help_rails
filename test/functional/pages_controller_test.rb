require 'test_helper'

class PagesControllerTest < ActionController::TestCase
  test "should get help" do
    get :help
    assert_response :success
  end

  test "should get success" do
    get :success
    assert_response :success
  end

end
