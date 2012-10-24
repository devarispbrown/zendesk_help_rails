require 'test_helper'

class HelpControllerTest < ActionController::TestCase
  test "should get tickets" do
    get :tickets
    assert_response :success
  end

end
