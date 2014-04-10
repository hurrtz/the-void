require 'test_helper'

class LocalControllerTest < ActionController::TestCase
  test "should get overview" do
    get :overview
    assert_response :success
  end

  test "should get fleet" do
    get :fleet
    assert_response :success
  end

  test "should get robotics" do
    get :robotics
    assert_response :success
  end

  test "should get research" do
    get :research
    assert_response :success
  end

  test "should get structures" do
    get :structures
    assert_response :success
  end

end
