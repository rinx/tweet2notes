require 'test_helper'

class LoginControllerTest < ActionController::TestCase
  test "should get twCallback" do
    get :twCallback
    assert_response :success
  end

  test "should get enCallback" do
    get :enCallback
    assert_response :success
  end

  test "should get twLogout" do
    get :twLogout
    assert_response :success
  end

  test "should get enLogout" do
    get :enLogout
    assert_response :success
  end

end
