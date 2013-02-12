require 'test_helper'

class ParameterControllerTest < ActionController::TestCase
  test "should get input" do
    get :input
    assert_response :success
  end

  test "should get register" do
    get :register
    assert_response :success
  end

end
